import 'package:core/core.dart';

import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_data_source.dart';
import '../datasources/orders_mock_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl({OrdersDataSource? dataSource})
      : _dataSource = dataSource ?? OrdersMockDataSource();

  final OrdersDataSource _dataSource;

  @override
  Future<Result<OrderEntity>> getOrderById(String orderId) {
    return guard(() => _dataSource.getOrderById(orderId));
  }

  @override
  Future<Result<List<OrderEntity>>> getInProgressOrders() {
    return guard(() => _dataSource.getInProgressOrders());
  }

  @override
  Future<Result<({double price, int expectedTimeMinutes})>> getDeliveryPrice({
    required String cookId,
    required double latitude,
    required double longitude,
  }) {
    return guard(() => _dataSource.getDeliveryPrice(
          cookId: cookId,
          latitude: latitude,
          longitude: longitude,
        ));
  }

  @override
  Future<Result<String>> confirmOrder({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
    double? latitude,
    double? longitude,
  }) {
    return guard(() => _dataSource.confirmOrder(
          cookId: cookId,
          deliveryAddress: deliveryAddress,
          deliveryFee: deliveryFee,
          mealItems: mealItems,
          offerItems: offerItems,
          returnedMealItems: returnedMealItems,
          latitude: latitude,
          longitude: longitude,
        ));
  }

  @override
  Future<Result<String>> confirmReturnedMealsOrder({
    required List<CartReturnedMealItemEntity> returnedMealItems,
    double? latitude,
    double? longitude,
  }) {
    return guard(() => _dataSource.confirmReturnedMealsOrder(
          returnedMealItems: returnedMealItems,
          latitude: latitude,
          longitude: longitude,
        ));
  }
}
