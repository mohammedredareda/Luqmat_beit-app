import 'package:equatable/equatable.dart';

/// One `ORDER_RETURNED_MEAL_ITEM` row — a discount-recovery meal folded
/// back into an order, distinct from a regular `OrderMealItemEntity` only
/// in that it carries the reason it was returned.
class OrderReturnedMealItemEntity extends Equatable {
  const OrderReturnedMealItemEntity({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    required this.returnedReason,
    this.note,
  });

  final String mealId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String returnedReason;
  final String? note;

  @override
  List<Object?> get props =>
      [mealId, name, imageUrl, quantity, priceAtPurchase, returnedReason, note];
}
