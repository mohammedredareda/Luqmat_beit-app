import 'package:core/core.dart';

import '../../../domain/meal_form_submission.dart';

abstract class CreateMealRepository {
  Future<Result<MealEntity>> createMeal(MealFormSubmission submission);
}
