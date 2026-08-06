import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class ConfirmOrder {
  const ConfirmOrder(this._repository);

  final OrdersRepository _repository;

  Future<Result<String>> call({
    required String cookId,
    required List<CartItemEntity> items,
    required double deliveryFee,
  }) {
    return _repository.confirmOrder(cookId: cookId, items: items, deliveryFee: deliveryFee);
  }
}
