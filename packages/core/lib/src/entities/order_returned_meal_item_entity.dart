import 'package:equatable/equatable.dart';

/// One `ORDER_RETURNED_MEAL_ITEM` line — a discount-recovery ("من نصيبك")
/// meal ordered from [ReturnedMealEntity]. `priceAtPurchase` snapshots the
/// returned meal's `salvagePrice` at order time.
class OrderReturnedMealItemEntity extends Equatable {
  final String id;
  final String returnedMealId;
  final String mealName;
  final String mealImageUrl;
  final double priceAtPurchase;
  final int quantity;

  const OrderReturnedMealItemEntity({
    required this.id,
    required this.returnedMealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.priceAtPurchase,
    required this.quantity,
  });

  double get subtotal => priceAtPurchase * quantity;

  @override
  List<Object?> get props =>
      [id, returnedMealId, mealName, mealImageUrl, priceAtPurchase, quantity];
}
