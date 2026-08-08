import 'package:core/core.dart';

import '../repositories/selectable_meals_repository.dart';

class GetSelectableMeals {
  GetSelectableMeals(this._repository);

  final SelectableMealsRepository _repository;

  Future<Result<List<MealEntity>>> call(String cookId) => _repository.getSelectableMeals(cookId);
}
