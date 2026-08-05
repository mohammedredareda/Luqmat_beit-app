import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_order_remote_data_source.dart';
import '../../domain/repositories/view_orders_repository.dart';

@LazySingleton(as: ViewOrdersRepository)
class ViewOrdersRepositoryImpl implements ViewOrdersRepository {
  ViewOrdersRepositoryImpl(this._dataSource);

  final FakeOrderRemoteDataSource _dataSource;

  @override
  Future<Result<PaginatedResult<OrderEntity>>> getOrders({
    required String cookId,
    OrderStatus? statusFilter,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final page = await _dataSource.getOrders(
        cookId: cookId,
        statusFilter: statusFilter,
        cursor: cursor,
        pageSize: pageSize,
      );
      return page.map((m) => m.toEntity());
    });
  }
}
