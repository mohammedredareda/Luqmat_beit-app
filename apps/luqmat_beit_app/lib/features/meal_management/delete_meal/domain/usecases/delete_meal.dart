import 'package:core/core.dart';

import '../repositories/delete_meal_repository.dart';

class DeleteMeal {
  DeleteMeal(this._repository);

  final DeleteMealRepository _repository;

  Future<Result<void>> call(String mealId) => _repository.deleteMeal(mealId);
}
