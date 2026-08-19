import 'package:core/core.dart';

/// CU-09/CU-10 — fetching a single meal's details and adding it to the
/// cart. `addToCart` is a mock no-op today (`Result.success(null)`) — a
/// separate `cart` feature owns real cart persistence; this repository
/// only needs to report success/failure of the intent to add.
abstract class MealDetailsRepository {
  Future<Result<MealEntity>> getMealById(String mealId);

  Future<Result<void>> addToCart({
    required String mealId,
    required String sellingOptionId,
    required int quantity,
    String? note,
  });

  /// Backed by `POST /user/customer/cart/returned-meals` — a returned/
  /// salvage meal is identified purely by `returnedMealId` server-side, no
  /// selling-option resolution needed (unlike [addToCart]).
  Future<Result<void>> addReturnedMealToCart({
    required String returnedMealId,
    required int count,
  });

  /// Backed by `POST`/`DELETE /user/customer/favorite`.
  Future<Result<void>> setFavorite(String mealId, bool isFavorite);

  /// Backed by `POST /user/customer/meal/report` — the backend only
  /// accepts this for a meal from one of the customer's delivered orders
  /// and rejects otherwise.
  Future<Result<void>> reportMeal(String mealId, String message);
}
