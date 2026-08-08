import 'package:core/core.dart';

import '../../domain/repositories/ratings_repository.dart';
import '../datasources/ratings_data_source.dart';
import '../datasources/ratings_mock_data_source.dart';

class RatingsRepositoryImpl implements RatingsRepository {
  RatingsRepositoryImpl({RatingsDataSource? dataSource})
      : _dataSource = dataSource ?? RatingsMockDataSource();

  final RatingsDataSource _dataSource;

  @override
  Future<Result<OrderEntity>> getOrderToRate(String orderId) {
    return guard(() => _dataSource.getOrderToRate(orderId));
  }

  @override
  Future<Result<void>> submitRating({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  }) {
    return guard(
      () => _dataSource.submitRating(
        orderId: orderId,
        stars: stars,
        review: review,
        mealId: mealId,
      ),
    );
  }
}
