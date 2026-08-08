import 'package:core/core.dart';

abstract class OrdersDataSource {
  Future<OrderEntity> getOrderById(String orderId);

  Future<List<OrderEntity>> getInProgressOrders();

  Future<String> confirmOrder({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
  });
}
