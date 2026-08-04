import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/order_details_repository.dart';

@injectable
class RejectOrder {
  RejectOrder(this._repository);

  final OrderDetailsRepository _repository;

  Future<Result<OrderEntity>> call({required String orderId, required String reason}) {
    return _repository.rejectOrder(orderId: orderId, reason: reason);
  }
}
