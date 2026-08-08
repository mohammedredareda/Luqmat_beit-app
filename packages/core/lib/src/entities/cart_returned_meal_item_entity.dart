import 'package:equatable/equatable.dart';

/// One `CART_RETURNED_MEAL_ITEM` row — the "من نصيبك" cart section. No
/// quantity stepper beyond the limited stock available when it was added.
class CartReturnedMealItemEntity extends Equatable {
  final String id;
  final String returnedMealId;
  final String mealName;
  final String mealImageUrl;
  final double salvagePrice;
  final int quantity;

  const CartReturnedMealItemEntity({
    required this.id,
    required this.returnedMealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.salvagePrice,
    required this.quantity,
  });

  double get subtotal => salvagePrice * quantity;

  @override
  List<Object?> get props =>
      [id, returnedMealId, mealName, mealImageUrl, salvagePrice, quantity];
}
