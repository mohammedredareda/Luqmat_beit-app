import 'package:core/core.dart';

import '../models/promotion_summary_model.dart';

/// Real Dio-backed data source for the unified offers+discounts feed
/// (`GET /user/cook/menu/promotions/my-promotions`) — replaces
/// `ViewOffersRepositoryImpl`'s old two-fake-datasource merge. See
/// `OfferFeedItemEntity`'s doc comment for why the feed is thin.
///
/// `.../menu/offers/my-promotions` (the previously confirmed working path)
/// broke once `GET /user/cook/menu/offers/{id}` was added: Express/Nest
/// matches routes in registration order, so `offers/:id` (with a numeric
/// `id` validator) now swallows `offers/my-promotions` first, rejecting it
/// with `"Validation failed (numeric string is expected)"` — confirmed
/// live, `offers/abc` fails with the identical message. The docs now list
/// this feed under its own `.../menu/promotions/my-promotions` path
/// instead, which doesn't collide with that route — confirmed live.
///
/// `status` accepts exactly `active` or `expired` (confirmed live —
/// anything else 400s with `"قيمة الفلتر يجب أن تكون active أو expired"`);
/// omit it entirely for the unfiltered feed. This replaced the old
/// client-side `expiryTime` filtering in `ViewOffersRepositoryImpl` now
/// that the server accepts it.
///
/// Confirmed live (2026-08): each row also carries an `image` URL, and
/// discounts additionally carry a nullable `usageRemaining` — a discount is
/// limited either by time (`expireTime`) or by usage count, never
/// necessarily both, so `expireTime` can be `null` when usage-limited. The
/// envelope itself (`data`/`meta.hasNextPage`) is unchanged.
class PromotionsRemoteDataSource {
  PromotionsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<PaginatedResult<PromotionSummaryModel>> getMyPromotions({
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
    String? status,
  }) async {
    final page = cursor == null ? 1 : int.parse(cursor);
    final response = await _apiClient.get(
      '/user/cook/menu/promotions/my-promotions',
      queryParameters: {'page': page, if (status != null) 'status': status},
    ) as Map;

    final itemsJson = response['data'] as List? ?? const [];
    final items = itemsJson
        .map((j) => PromotionSummaryModel.fromJson((j as Map).cast<String, dynamic>()))
        .toList();

    final meta = response['meta'] as Map?;
    final hasNextPage =
        meta != null ? (meta['hasNextPage'] as bool? ?? false) : items.length >= pageSize;

    return PaginatedResult(
      items: items,
      hasMore: hasNextPage,
      nextCursor: hasNextPage ? (page + 1).toString() : null,
    );
  }
}
