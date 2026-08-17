import 'package:equatable/equatable.dart';

import 'cart_meal_item_entity.dart';
import 'cart_offer_item_entity.dart';

/// One cook's section of the cart — the backend's `GET
/// /user/customer/cart` groups `meals`/`offers` under a `cooks` array (a
/// customer can have items from more than one cook in their cart at once,
/// confirmed against the shopping-cart mockup's multiple collapsible
/// cook cards), each confirmed independently via its own `cook_id`.
class CartCookGroupEntity extends Equatable {
  final String cookId;
  final String cookName;
  final String? cookAvatarUrl;
  final List<CartMealItemEntity> mealItems;
  final List<CartOfferItemEntity> offerItems;

  const CartCookGroupEntity({
    required this.cookId,
    required this.cookName,
    this.cookAvatarUrl,
    this.mealItems = const [],
    this.offerItems = const [],
  });

  bool get isEmpty => mealItems.isEmpty && offerItems.isEmpty;

  double get subtotal =>
      mealItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      offerItems.fold(0.0, (sum, i) => sum + i.subtotal);

  @override
  List<Object?> get props => [cookId, cookName, cookAvatarUrl, mealItems, offerItems];
}
