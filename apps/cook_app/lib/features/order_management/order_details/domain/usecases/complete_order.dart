import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/order_details_repository.dart';

@injectable
class CompleteOrder {
  CompleteOrder(this._repository);

  final OrderDetailsRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) => _repository.completeOrder(orderId);
}
