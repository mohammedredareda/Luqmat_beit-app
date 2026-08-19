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
  Future<Result<void>> updateSellingOption(
      String cartItemId, String sellingOptionId);
  Future<Result<void>> updateNote(String cartItemId, String note);
  Future<Result<void>> addReturnedMeal(
      {required String returnedMealId, required int count});
  Future<Result<void>> addOffer({required String offerId, required int count});
}
