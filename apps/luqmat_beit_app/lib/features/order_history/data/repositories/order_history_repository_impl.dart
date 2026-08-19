import 'package:core/core.dart';

import '../../domain/repositories/order_history_repository.dart';
import '../datasources/order_history_data_source.dart';
import '../datasources/order_history_mock_data_source.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  OrderHistoryRepositoryImpl({OrderHistoryDataSource? dataSource})
      : _dataSource = dataSource ?? OrderHistoryMockDataSource();

  final OrderHistoryDataSource _dataSource;

  @override
  Future<Result<List<OrderEntity>>> getOrderHistory() {
    return guard(() => _dataSource.getOrderHistory());
  }

  @override
  Future<Result<void>> reorder(String orderId) {
    return guard(() => _dataSource.reorder(orderId));
  }
}
