import 'package:core/core.dart';

import '../repositories/order_history_repository.dart';

class GetOrderHistory {
  const GetOrderHistory(this._repository);

  final OrderHistoryRepository _repository;

  Future<Result<List<OrderEntity>>> call() => _repository.getOrderHistory();
}
