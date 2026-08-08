import 'package:core/core.dart';

import '../repositories/delivery_repository.dart';

class GetDeliveredOrder {
  const GetDeliveredOrder(this._repository);

  final DeliveryRepository _repository;

  Future<Result<OrderEntity>> call(String orderId) =>
      _repository.getDeliveredOrder(orderId);
}
