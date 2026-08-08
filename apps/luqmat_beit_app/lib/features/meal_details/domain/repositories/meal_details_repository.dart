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

  /// Backed by `POST`/`DELETE /user/customer/favorite`.
  Future<Result<void>> setFavorite(String mealId, bool isFavorite);
}
