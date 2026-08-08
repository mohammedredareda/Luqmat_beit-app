import 'package:equatable/equatable.dart';

/// One `ORDER_MEAL_ITEM` line — `priceAtPurchase` is snapshotted at order
/// time and never recomputed from the live meal/selling-option price later.
class OrderMealItemEntity extends Equatable {
  final String id;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String? sellingOptionLabel;
  final double priceAtPurchase;
  final int quantity;
  final String? note;

  const OrderMealItemEntity({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.priceAtPurchase,
    required this.quantity,
    this.sellingOptionLabel,
    this.note,
  });

  double get subtotal => priceAtPurchase * quantity;

  @override
  List<Object?> get props => [
        id,
        mealId,
        mealName,
        mealImageUrl,
        sellingOptionLabel,
        priceAtPurchase,
        quantity,
        note,
      ];
}
