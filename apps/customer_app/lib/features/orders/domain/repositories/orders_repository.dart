import 'package:core/core.dart';

/// CU-17/18/19/31: checkout, order confirmation, invoice and the
/// in-progress orders list all read/write through this single repository.
abstract class OrdersRepository {
  Future<Result<OrderEntity>> getOrderById(String orderId);

  Future<Result<List<OrderEntity>>> getInProgressOrders();

  /// Places an order for a single cook's cart lines (the backend's
  /// `/order/confirm` endpoint is per-cook, not per-cart) and returns the
  /// new order id.
  Future<Result<String>> confirmOrder({
    required String cookId,
    required List<CartItemEntity> items,
    required double deliveryFee,
  });
}
