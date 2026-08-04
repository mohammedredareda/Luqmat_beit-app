import 'package:equatable/equatable.dart';

/// One `ORDER_MEAL_ITEM` row — a regular menu meal on an order, snapshotting
/// its price at purchase time so later meal-price edits never affect
/// already-placed orders.
class OrderMealItemEntity extends Equatable {
  const OrderMealItemEntity({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
    this.selectedOptionLabel,
  });

  final String mealId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;

  /// The selling-option variation the customer chose (e.g. a size label
  /// like "وسط"), when this meal sells with variations (CK-07). Null for
  /// meals with a single flat price.
  final String? selectedOptionLabel;

  @override
  List<Object?> get props =>
      [mealId, name, imageUrl, quantity, priceAtPurchase, note, selectedOptionLabel];
}
