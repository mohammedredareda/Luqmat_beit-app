import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_order_remote_data_source.dart';
import '../../domain/repositories/view_orders_repository.dart';

@LazySingleton(as: ViewOrdersRepository)
class ViewOrdersRepositoryImpl implements ViewOrdersRepository {
  ViewOrdersRepositoryImpl(this._dataSource);

  final FakeOrderRemoteDataSource _dataSource;

  @override
  Future<Result<List<OrderEntity>>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
  }) {
    return guard(() async {
      final models = await _dataSource.getOrders(cookId: cookId, statusFilter: statusFilter);
      return models.map((m) => m.toEntity()).toList();
    });
  }
}
