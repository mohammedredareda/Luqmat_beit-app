import 'package:equatable/equatable.dart';

/// One `CART_MEAL_ITEM` row.
class CartMealItemEntity extends Equatable {
  final String id;
  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String? sellingOptionId;
  final String? sellingOptionLabel;
  final double unitPrice;
  final int quantity;
  final String? note;

  const CartMealItemEntity({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.unitPrice,
    required this.quantity,
    this.sellingOptionId,
    this.sellingOptionLabel,
    this.note,
  });

  double get subtotal => unitPrice * quantity;

  CartMealItemEntity copyWith({int? quantity, String? note}) =>
      CartMealItemEntity(
        id: id,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        sellingOptionId: sellingOptionId,
        sellingOptionLabel: sellingOptionLabel,
        unitPrice: unitPrice,
        quantity: quantity ?? this.quantity,
        note: note ?? this.note,
      );

  @override
  List<Object?> get props => [
        id,
        mealId,
        mealName,
        mealImageUrl,
        sellingOptionId,
        sellingOptionLabel,
        unitPrice,
        quantity,
        note,
      ];
}
