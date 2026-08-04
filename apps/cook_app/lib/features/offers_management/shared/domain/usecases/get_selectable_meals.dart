import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/selectable_meals_repository.dart';

@injectable
class GetSelectableMeals {
  GetSelectableMeals(this._repository);

  final SelectableMealsRepository _repository;

  Future<Result<List<MealEntity>>> call(String cookId) => _repository.getSelectableMeals(cookId);
}
