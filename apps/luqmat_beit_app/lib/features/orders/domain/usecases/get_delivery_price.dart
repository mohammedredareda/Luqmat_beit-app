import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class GetDeliveryPrice {
  const GetDeliveryPrice(this._repository);

  final OrdersRepository _repository;

  Future<Result<({double price, int expectedTimeMinutes})>> call({
    required String cookId,
    required double latitude,
    required double longitude,
  }) {
    return _repository.getDeliveryPrice(
      cookId: cookId,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
