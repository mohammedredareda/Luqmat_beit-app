import 'package:core/core.dart';

import '../repositories/order_history_repository.dart';

class ReorderPastOrder {
  const ReorderPastOrder(this._repository);

  final OrderHistoryRepository _repository;

  Future<Result<void>> call(String orderId) => _repository.reorder(orderId);
}
