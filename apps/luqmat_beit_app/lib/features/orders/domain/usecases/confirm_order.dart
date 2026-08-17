import 'package:core/core.dart';

import '../repositories/orders_repository.dart';

class ConfirmOrder {
  const ConfirmOrder(this._repository);

  final OrdersRepository _repository;

  Future<Result<String>> call({
    required String cookId,
    required String deliveryAddress,
    required double deliveryFee,
    List<CartMealItemEntity> mealItems = const [],
    List<CartOfferItemEntity> offerItems = const [],
    List<CartReturnedMealItemEntity> returnedMealItems = const [],
    double? latitude,
    double? longitude,
  }) {
    return _repository.confirmOrder(
      cookId: cookId,
      deliveryAddress: deliveryAddress,
      deliveryFee: deliveryFee,
      mealItems: mealItems,
      offerItems: offerItems,
      returnedMealItems: returnedMealItems,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
