import 'package:core/core.dart';

import '../repositories/meal_details_repository.dart';

class ToggleMealFavorite {
  const ToggleMealFavorite(this._repository);

  final MealDetailsRepository _repository;

  Future<Result<void>> call(String mealId, bool isFavorite) {
    return _repository.setFavorite(mealId, isFavorite);
  }
}
