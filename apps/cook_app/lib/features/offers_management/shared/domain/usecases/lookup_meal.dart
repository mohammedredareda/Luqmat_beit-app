import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/selectable_meals_repository.dart';

/// Resolves a meal's full [MealEntity] (including its `sellingOptions`)
/// so an offer row's selling-option chip can re-open the picker dialog —
/// the row itself only stores the *chosen* option, not the full list.
@injectable
class LookupMeal {
  LookupMeal(this._repository);

  final SelectableMealsRepository _repository;

  Future<Result<MealEntity>> call(String mealId) => _repository.getMealById(mealId);
}
