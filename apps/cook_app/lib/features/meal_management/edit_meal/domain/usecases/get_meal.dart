import 'package:core/core.dart';

import '../repositories/edit_meal_repository.dart';

class GetMeal {
  GetMeal(this._repository);

  final EditMealRepository _repository;

  Future<Result<MealEntity>> call(String mealId) => _repository.getMeal(mealId);
}
