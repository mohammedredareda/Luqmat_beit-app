import 'package:core/core.dart';

import '../models/discount_model.dart';

/// Real Dio-backed data source for the discounts endpoints — replaces
/// `FakeDiscountsRemoteDataSource` entirely now that a GET-by-id
/// (`GET /user/cook/menu/discounts/{id}`) is documented, so `updateDiscount`'s
/// prefill can be real too.
class DiscountsRemoteDataSource {
  DiscountsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<DiscountModel> createDiscount(DiscountModel discount) async {
    await _apiClient.post(
      '/user/cook/menu/discounts/create',
      data: discount.toApiRequestFields(),
    );
    // No created-discount payload in the response either.
    return discount;
  }

  Future<DiscountModel?> getDiscountById(String id) async {
    final response = await _apiClient.get('/user/cook/menu/discounts/$id') as Map;
    final data = response['data'];
    if (data is! Map) return null;
    return DiscountModel.fromApiJson(data.cast<String, dynamic>());
  }

  /// `PUT /user/cook/menu/discounts/{id}` — `{discount_percentage,
  /// discount_duration, usage_limit}`, with exactly one of
  /// `discount_duration`/`usage_limit` sent as `null` (see
  /// `DiscountModel.toApiRequestFields`'s doc comment — same mutual-
  /// exclusivity rule, confirmed live on this endpoint too). Its `200`
  /// response's `data` is the same shape `getDiscountById` parses (minus
  /// the nested `meal`), so the response is used directly rather than
  /// re-fetching.
  Future<DiscountModel> updateDiscount(DiscountModel discount) async {
    final response = await _apiClient.put(
      '/user/cook/menu/discounts/${discount.id}',
      data: {
        'discount_percentage': discount.discountPercentage,
        'discount_duration':
            discount.usageNumberLimit != null ? null : discount.discountDurationDays,
        'usage_limit': discount.usageNumberLimit,
      },
    ) as Map;
    final data = response['data'];
    if (data is! Map) return discount;
    final saved = DiscountModel.fromApiJson(data.cast<String, dynamic>());
    // The PUT response has no nested `meal` — keep the display fields the
    // caller already had (they came from a fresh `getDiscountById` call
    // just before this, via EditDiscountRepositoryImpl.updateDiscount).
    return saved.copyWith(mealName: discount.mealName, mealImageUrl: discount.mealImageUrl);
  }

  Future<void> deleteDiscount(String id) async {
    await _apiClient.delete('/user/cook/menu/discounts/$id');
  }
}
