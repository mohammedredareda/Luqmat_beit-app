import 'package:core/core.dart';

import '../repositories/order_details_repository.dart';

class RejectOrder {
  RejectOrder(this._repository);

  final OrderDetailsRepository _repository;

  Future<Result<OrderEntity>> call({required String orderId, required String reason}) {
    return _repository.rejectOrder(orderId: orderId, reason: reason);
  }
}
