import 'package:core/core.dart';

import '../entities/offer_feed_filter.dart';
import '../entities/offer_feed_item_entity.dart';

abstract class ViewOffersRepository {
  /// One page of the cook's offers+discounts, merged into a single feed
  /// and optionally narrowed by [filter]. `cursor: null` requests the
  /// first page.
  Future<Result<PaginatedResult<OfferFeedItemEntity>>> getOffersFeed(
    String cookId, {
    OfferFeedFilter filter = OfferFeedFilter.all,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
