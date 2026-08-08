import 'package:core/core.dart';

import '../repositories/meal_details_repository.dart';

class GetMealDetails {
  const GetMealDetails(this._repository);

  final MealDetailsRepository _repository;

  Future<Result<MealEntity>> call(String mealId) =>
      _repository.getMealById(mealId);
}
