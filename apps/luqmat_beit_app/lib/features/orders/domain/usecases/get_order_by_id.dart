import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class GetOrderById {
  const GetOrderById(this._repository);

  final OrdersRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) =>
      _repository.getOrderById(orderId);
}
