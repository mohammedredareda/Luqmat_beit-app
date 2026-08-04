import 'package:core/core.dart';

/// Backs both the Select Meal popup and the offer row's selling-option-
/// chip re-pick. The only place `offers_management` code touches meal
/// data — it never mutates it.
abstract class SelectableMealsRepository {
  /// Cook's own *active* meals only — inactive/stopped meals can't be
  /// added to a new offer/discount.
  Future<Result<List<MealEntity>>> getSelectableMeals(String cookId);

  Future<Result<MealEntity>> getMealById(String mealId);
}
