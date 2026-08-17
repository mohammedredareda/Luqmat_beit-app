import 'package:equatable/equatable.dart';

import 'selling_option_entity.dart';

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

  /// Pre-discount unit price and the discount percentage applied to reach
  /// [unitPrice] (which is the backend's `final_price`, already
  /// discounted). `/order/confirm` validates the order by recomputing
  /// `originalPrice * (1 - discountPercentage / 100)` server-side and
  /// comparing it against the resubmitted `final_price` — sending
  /// [unitPrice] back as both `price` and `final_price` with a 0% discount
  /// fails that check (rejected as "prices have changed") whenever the meal
  /// actually has a discount, so both have to be carried through from the
  /// cart response rather than reconstructed.
  final double originalPrice;
  final double discountPercentage;

  /// Every selling option the meal offers (not just the one currently
  /// chosen) — lets the cart screen offer the same "صغير/وسط/كبير"-style
  /// chip picker CU-10 (meal details) has, instead of only showing the
  /// selected option as static text.
  final List<SellingOptionEntity> availableSellingOptions;

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
    double? originalPrice,
    this.discountPercentage = 0,
    this.availableSellingOptions = const [],
  }) : originalPrice = originalPrice ?? unitPrice;

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
        originalPrice: originalPrice,
        discountPercentage: discountPercentage,
        availableSellingOptions: availableSellingOptions,
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
        originalPrice,
        discountPercentage,
        availableSellingOptions,
      ];
}
