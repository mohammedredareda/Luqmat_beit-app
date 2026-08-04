import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/view_orders_repository.dart';

@injectable
class GetOrders {
  GetOrders(this._repository);

  final ViewOrdersRepository _repository;

  Future<Result<List<OrderEntity>>> call({
    required String cookId,
    OrderStatus? statusFilter,
  }) {
    return _repository.getOrders(cookId: cookId, statusFilter: statusFilter);
  }
}
