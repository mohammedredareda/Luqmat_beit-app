import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class GetInProgressOrders {
  const GetInProgressOrders(this._repository);

  final OrdersRepository _repository;

  Future<Result<List<OrderEntity>>> call() =>
      _repository.getInProgressOrders();
}
