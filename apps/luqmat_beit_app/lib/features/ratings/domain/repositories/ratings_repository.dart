import 'package:core/core.dart';

/// CU-23 (Ratings, Reviews & Reporting): rate a delivered order's meal(s)
/// with a star score and an optional written review.
abstract class RatingsRepository {
  Future<Result<OrderEntity>> getOrderToRate(String orderId);

  /// [mealId] is required by the backend (`POST /user/customer/meal/rating`
  /// rates a meal, not an order) — passed alongside [orderId] since this
  /// repository's contract stays order-centric for the rest of the app.
  Future<Result<void>> submitRating({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  });
}
