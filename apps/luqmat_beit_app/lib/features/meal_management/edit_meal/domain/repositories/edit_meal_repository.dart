import 'package:core/core.dart';

import '../../../domain/meal_form_submission.dart';

abstract class EditMealRepository {
  Future<Result<MealEntity>> getMeal(String mealId);

  Future<Result<MealEntity>> updateMeal(
    String mealId,
    MealFormSubmission submission, {
    required bool isStopped,
  });
}
