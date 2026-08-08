import 'package:core/core.dart';

import '../repositories/ratings_repository.dart';

class SubmitMealRating {
  const SubmitMealRating(this._repository);

  final RatingsRepository _repository;

  Future<Result<void>> call({
    required String orderId,
    required int stars,
    String? review,
    String? mealId,
  }) {
    return _repository.submitRating(
      orderId: orderId,
      stars: stars,
      review: review,
      mealId: mealId,
    );
  }
}
