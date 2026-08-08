import 'package:equatable/equatable.dart';

import 'cart_meal_item_entity.dart';
import 'cart_offer_item_entity.dart';
import 'cart_returned_meal_item_entity.dart';

/// `CART` is a thin parent row — items live in the three typed child
/// tables, same pattern as [OrderEntity]. A cart can only ever hold items
/// from one cook at a time; [cookId] is null when the cart is empty.
class CartEntity extends Equatable {
  final String customerId;
  final String? cookId;
  final List<CartMealItemEntity> mealItems;
  final List<CartOfferItemEntity> offerItems;
  final List<CartReturnedMealItemEntity> returnedMealItems;

  const CartEntity({
    required this.customerId,
    this.cookId,
    this.mealItems = const [],
    this.offerItems = const [],
    this.returnedMealItems = const [],
  });

  bool get isEmpty =>
      mealItems.isEmpty && offerItems.isEmpty && returnedMealItems.isEmpty;

  double get itemsTotal =>
      mealItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      offerItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      returnedMealItems.fold(0.0, (sum, i) => sum + i.subtotal);

  @override
  List<Object?> get props =>
      [customerId, cookId, mealItems, offerItems, returnedMealItems];
}
