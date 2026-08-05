import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/in_memory_pagination.dart';
import '../../../shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../../../shared/data/datasources/fake_offers_remote_data_source.dart';
import '../../../shared/data/models/discount_model.dart';
import '../../../shared/data/models/offer_model.dart';
import '../../domain/entities/offer_feed_filter.dart';
import '../../domain/entities/offer_feed_item_entity.dart';
import '../../domain/repositories/view_offers_repository.dart';

@LazySingleton(as: ViewOffersRepository)
class ViewOffersRepositoryImpl implements ViewOffersRepository {
  ViewOffersRepositoryImpl(this._offersDataSource, this._discountsDataSource);

  final FakeOffersRemoteDataSource _offersDataSource;
  final FakeDiscountsRemoteDataSource _discountsDataSource;

  @override
  Future<Result<PaginatedResult<OfferFeedItemEntity>>> getOffersFeed(
    String cookId, {
    OfferFeedFilter filter = OfferFeedFilter.all,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final results = await Future.wait([
        _offersDataSource.getMyOffers(cookId),
        _discountsDataSource.getMyDiscounts(cookId),
      ]);
      final offerModels = results[0] as List<OfferModel>;
      final discountModels = results[1] as List<DiscountModel>;

      final feed = <OfferFeedItemEntity>[
        for (final model in offerModels) OfferFeedOfferItem(model.toEntity()),
        for (final model in discountModels) OfferFeedDiscountItem(model.toEntity()),
      ].where((item) => _matchesFilter(item, filter)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return paginateInMemory(
        all: feed,
        idOf: (item) => item.id,
        cursor: cursor,
        pageSize: pageSize,
      );
    });
  }

  bool _matchesFilter(OfferFeedItemEntity item, OfferFeedFilter filter) {
    if (filter == OfferFeedFilter.all) return true;
    final expired = switch (item) {
      OfferFeedOfferItem(:final offer) => offer.remainingDays <= 0,
      OfferFeedDiscountItem(:final discount) =>
        (discount.remainingDays != null && discount.remainingDays! <= 0) ||
            (discount.remainingUsage != null && discount.remainingUsage! <= 0),
    };
    final isActive = switch (item) {
      OfferFeedOfferItem(:final offer) => offer.isActive,
      OfferFeedDiscountItem(:final discount) => discount.isActive,
    };
    return filter == OfferFeedFilter.active ? (!expired && isActive) : expired;
  }
}
