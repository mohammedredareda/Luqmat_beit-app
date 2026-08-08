import 'package:core/core.dart';

abstract class CartDataSource {
  Future<CartEntity> getCart();

  Future<void> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  });

  Future<void> updateQuantity(String cartItemId, int quantity);

  /// Looks across meal/offer/returned-meal lines to find and remove the
  /// matching item — the caller doesn't need to know which typed list a
  /// given cart-item id belongs to.
  Future<void> removeItem(String cartItemId);

  Future<void> updateSellingOption(String cartItemId, String sellingOptionId);
}
