import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class ConfirmReturnedMealsOrder {
  const ConfirmReturnedMealsOrder(this._repository);

  final OrdersRepository _repository;

  Future<Result<String>> call({
    required List<CartReturnedMealItemEntity> returnedMealItems,
    double? latitude,
    double? longitude,
  }) {
    return _repository.confirmReturnedMealsOrder(
      returnedMealItems: returnedMealItems,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
