import 'package:equatable/equatable.dart';

import 'meal_entity.dart';
import 'selling_option_entity.dart';

class CartItemEntity extends Equatable {
  final String id;
  final MealEntity meal;
  final SellingOptionEntity sellingOption;
  final int quantity;
  final String? note;

  const CartItemEntity({
    required this.id,
    required this.meal,
    required this.sellingOption,
    required this.quantity,
    this.note,
  });

  double get subtotal => sellingOption.price * quantity;

  CartItemEntity copyWith({int? quantity, String? note}) => CartItemEntity(
        id: id,
        meal: meal,
        sellingOption: sellingOption,
        quantity: quantity ?? this.quantity,
        note: note ?? this.note,
      );

  @override
  List<Object?> get props => [id, meal, sellingOption, quantity, note];
}
