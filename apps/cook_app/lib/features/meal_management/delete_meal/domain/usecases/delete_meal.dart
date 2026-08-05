import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delete_meal_repository.dart';

@injectable
class DeleteMeal {
  DeleteMeal(this._repository);

  final DeleteMealRepository _repository;

  Future<Result<void>> call(String mealId) => _repository.deleteMeal(mealId);
}
