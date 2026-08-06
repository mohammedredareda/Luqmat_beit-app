import 'package:core/core.dart';

abstract class RatingsDataSource {
  Future<OrderEntity> getOrderToRate(String orderId);

  Future<void> submitRating({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  });
}
