import 'package:core/core.dart';

abstract class CartDataSource {
  Future<List<CartItemEntity>> getCartItems();

  Future<void> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  });

  Future<void> updateQuantity(String cartItemId, int quantity);

  Future<void> removeItem(String cartItemId);

  Future<void> updateSellingOption(String cartItemId, String sellingOptionId);
}
