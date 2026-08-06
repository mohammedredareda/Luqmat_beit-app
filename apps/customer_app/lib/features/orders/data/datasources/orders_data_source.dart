import 'package:core/core.dart';

abstract class OrdersDataSource {
  Future<OrderEntity> getOrderById(String orderId);

  Future<List<OrderEntity>> getInProgressOrders();

  Future<String> confirmOrder({
    required String cookId,
    required List<CartItemEntity> items,
    required double deliveryFee,
  });
}
