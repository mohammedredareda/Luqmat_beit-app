import 'package:equatable/equatable.dart';

/// `priceAtPurchase` is snapshotted at order time — never recomputed from
/// the live meal/selling-option price later.
class OrderItemEntity extends Equatable {
  final String id;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String sellingOptionLabel;
  final double priceAtPurchase;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.sellingOptionLabel,
    required this.priceAtPurchase,
    required this.quantity,
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
      ];
}
