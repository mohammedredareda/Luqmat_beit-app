import 'package:core/core.dart';

import '../../../shared/data/datasources/promotions_remote_data_source.dart';
import '../../../shared/data/models/promotion_summary_model.dart';
import '../../domain/entities/offer_feed_filter.dart';
import '../../domain/entities/offer_feed_item_entity.dart';
import '../../domain/repositories/view_offers_repository.dart';

class ViewOffersRepositoryImpl implements ViewOffersRepository {
  ViewOffersRepositoryImpl(this._dataSource);

  final PromotionsRemoteDataSource _dataSource;

  @override
  Future<Result<PaginatedResult<OfferFeedItemEntity>>> getOffersFeed(
    String cookId, {
    OfferFeedFilter filter = OfferFeedFilter.all,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final page = await _dataSource.getMyPromotions(
        cursor: cursor,
        pageSize: pageSize,
        status: _statusParam(filter),
      );
      return PaginatedResult(
        items: page.items.map(_toFeedItem).toList(),
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      );
    });
  }

  /// Server-side filter value — confirmed live to accept only `active` or
  /// `expired`, omitted entirely for [OfferFeedFilter.all].
  String? _statusParam(OfferFeedFilter filter) => switch (filter) {
        OfferFeedFilter.all => null,
        OfferFeedFilter.active => 'active',
        OfferFeedFilter.expired => 'expired',
      };

  OfferFeedItemEntity _toFeedItem(PromotionSummaryModel model) => switch (model.type) {
        PromotionItemType.offer => OfferFeedOfferItem(
            rawId: model.id,
            title: model.title,
            description: model.description,
            createdAt: model.createdAt,
            expiryTime: model.expiryTime,
            image: model.image,
          ),
        PromotionItemType.discount => OfferFeedDiscountItem(
            rawId: model.id,
            title: model.title,
            description: model.description,
            createdAt: model.createdAt,
            expiryTime: model.expiryTime,
            image: model.image,
            usageRemaining: model.usageRemaining,
          ),
      };
}
