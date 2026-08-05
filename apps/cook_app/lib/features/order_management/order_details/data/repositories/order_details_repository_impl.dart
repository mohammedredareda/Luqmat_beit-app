import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_order_remote_data_source.dart';
import '../../domain/repositories/order_details_repository.dart';

@LazySingleton(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  OrderDetailsRepositoryImpl(this._dataSource);

  final FakeOrderRemoteDataSource _dataSource;

  @override
  Future<Result<OrderEntity>> getOrder(String orderId) {
    return guard(() async {
      final model = await _dataSource.getOrderById(orderId);
      if (model == null) throw const NotFoundException('Order not found');
      return model.toEntity();
    });
  }

  @override
  Future<Result<OrderEntity>> acceptOrder(String orderId) {
    return guard(() async => (await _dataSource.acceptOrder(orderId)).toEntity());
  }

  @override
  Future<Result<OrderEntity>> rejectOrder({required String orderId, required String reason}) {
    return guard(() async =>
        (await _dataSource.rejectOrder(id: orderId, reason: reason)).toEntity());
  }

  @override
  Future<Result<OrderEntity>> completeOrder(String orderId) {
    return guard(() async => (await _dataSource.completeOrder(orderId)).toEntity());
  }
}
