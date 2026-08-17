import 'package:core/core.dart';

abstract class OrdersDataSource {
  Future<OrderEntity> getOrderById(String orderId);

  Future<List<OrderEntity>> getInProgressOrders();

  /// [latitude]/[longitude], when given, come from the customer's own
  /// "تحديد الموقع" pick for this order; falls back to whatever the
  /// datasource has cached (e.g. the registration-time location) otherwise.
  Future<String> confirmOrder({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
    double? latitude,
    double? longitude,
  });
}
