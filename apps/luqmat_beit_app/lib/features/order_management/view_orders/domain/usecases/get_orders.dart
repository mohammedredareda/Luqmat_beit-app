import 'package:core/core.dart';

import '../repositories/view_orders_repository.dart';

class GetOrders {
  GetOrders(this._repository);

  final ViewOrdersRepository _repository;

  Future<Result<PaginatedResult<OrderEntity>>> call({
    required String cookId,
    OrderStatus? statusFilter,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return _repository.getOrders(
      cookId: cookId,
      statusFilter: statusFilter,
      cursor: cursor,
      pageSize: pageSize,
    );
  }
}
