import 'package:core/core.dart';

abstract class CartRepository {
  Future<Result<CartEntity>> getCart();
  Future<Result<void>> addItem({
    required MealEntity meal,
    required SellingOptionEntity sellingOption,
    required int quantity,
    String? note,
  });
  Future<Result<void>> updateQuantity(String cartItemId, int quantity);
  Future<Result<void>> removeItem(String cartItemId);
  Future<Result<void>> updateSellingOption(String cartItemId, String sellingOptionId);
}
