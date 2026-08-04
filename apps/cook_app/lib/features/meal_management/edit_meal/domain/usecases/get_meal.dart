import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/edit_meal_repository.dart';

@injectable
class GetMeal {
  GetMeal(this._repository);

  final EditMealRepository _repository;

  Future<Result<MealEntity>> call(String mealId) => _repository.getMeal(mealId);
}
