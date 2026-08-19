import 'package:core/core.dart';

/// CU-17/18/19/31: checkout, order confirmation, invoice and the
/// in-progress orders list all read/write through this single repository.
abstract class OrdersRepository {
  Future<Result<OrderEntity>> getOrderById(String orderId);

  Future<Result<List<OrderEntity>>> getInProgressOrders();

  /// Real, distance-based delivery price/expected-time for a single cook
  /// (the backend's `/order/delivery-price` is per-cook, not per-cart) —
  /// what `/order/confirm` actually charges is always recomputed
  /// server-side from the same inputs, so this is purely a "show the
  /// customer what they'll pay before they commit" preview.
  Future<Result<({double price, int expectedTimeMinutes})>> getDeliveryPrice({
    required String cookId,
    required double latitude,
    required double longitude,
  });

  /// Places an order for a single cook's cart lines (the backend's
  /// `/order/confirm` endpoint is per-cook, not per-cart) and returns the
  /// new order id.
  Future<Result<String>> confirmOrder({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
    double? latitude,
    double? longitude,
  });

  /// Places an order for "من نصيبك" (returned/salvage meal) cart lines only
  /// — a distinct request shape from [confirmOrder]: no `cook_id` at all
  /// (these aren't grouped by cook), sent instead with
  /// `is_returned_meals_order: true`.
  Future<Result<String>> confirmReturnedMealsOrder({
    required List<CartReturnedMealItemEntity> returnedMealItems,
    double? latitude,
    double? longitude,
  });
}
