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
  Future<Result<String>> confirmOrder({
    required String cookId,
    required List<CartItemEntity> items,
    required double deliveryFee,
  }) {
    return guard(
      () => _dataSource.confirmOrder(cookId: cookId, items: items, deliveryFee: deliveryFee),
    );
  }
}
