import 'package:core/core.dart';

import '../repositories/order_details_repository.dart';

class CompleteOrder {
  CompleteOrder(this._repository);

  final OrderDetailsRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) => _repository.completeOrder(orderId);
}
