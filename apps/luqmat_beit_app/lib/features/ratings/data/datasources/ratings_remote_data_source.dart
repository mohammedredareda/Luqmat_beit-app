import 'package:core/core.dart';

import 'ratings_data_source.dart';
import 'ratings_mock_data_source.dart';

/// Real implementation of `submitRating` only — backed by
/// `POST /user/customer/meal/rating`. There is no backend endpoint to fetch
/// "the order to rate" by id, so `getOrderToRate` keeps delegating to the
/// mock (per the connect-backend plan) rather than guessing at one.
class RatingsRemoteDataSource implements RatingsDataSource {
  RatingsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;
  final RatingsMockDataSource _fallback = RatingsMockDataSource();

  @override
  Future<OrderEntity> getOrderToRate(String orderId) => _fallback.getOrderToRate(orderId);

  @override
  Future<void> submitRating({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  }) async {
    await _apiClient.post('/user/customer/meal/rating', data: {
      'meal_id': mealId ?? '',
      'rate': stars.toString(),
    });
  }
}
