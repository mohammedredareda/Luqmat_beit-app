import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../entities/offer_feed_filter.dart';
import '../entities/offer_feed_item_entity.dart';
import '../repositories/view_offers_repository.dart';

@injectable
class GetOffersFeed {
  GetOffersFeed(this._repository);

  final ViewOffersRepository _repository;

  Future<Result<PaginatedResult<OfferFeedItemEntity>>> call(
    String cookId, {
    OfferFeedFilter filter = OfferFeedFilter.all,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) =>
      _repository.getOffersFeed(cookId, filter: filter, cursor: cursor, pageSize: pageSize);
}
