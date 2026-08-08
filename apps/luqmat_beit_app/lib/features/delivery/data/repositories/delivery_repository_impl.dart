import 'package:core/core.dart';

import '../../domain/repositories/delivery_repository.dart';
import '../datasources/delivery_mock_data_source.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  DeliveryRepositoryImpl({DeliveryMockDataSource? dataSource})
      : _dataSource = dataSource ?? DeliveryMockDataSource();

  final DeliveryMockDataSource _dataSource;

  @override
  Future<Result<OrderEntity>> getDeliveredOrder(String orderId) {
    return guard(() => _dataSource.getDeliveredOrder(orderId));
  }

  @override
  Future<Result<void>> confirmReceipt(String orderId) {
    return guard(() => _dataSource.confirmReceipt(orderId));
  }

  @override
  Future<Result<void>> reportIssue(String orderId, String reason) {
    return guard(() => _dataSource.reportIssue(orderId, reason));
  }
}
