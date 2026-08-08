import 'package:core/core.dart';

import '../repositories/order_details_repository.dart';

class AcceptOrder {
  AcceptOrder(this._repository);

  final OrderDetailsRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) => _repository.acceptOrder(orderId);
}
