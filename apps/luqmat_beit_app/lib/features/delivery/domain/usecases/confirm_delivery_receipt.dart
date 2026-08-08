import 'package:core/core.dart';

import '../repositories/delivery_repository.dart';

class ConfirmDeliveryReceipt {
  const ConfirmDeliveryReceipt(this._repository);

  final DeliveryRepository _repository;

  Future<Result<void>> call(String orderId) =>
      _repository.confirmReceipt(orderId);
}
