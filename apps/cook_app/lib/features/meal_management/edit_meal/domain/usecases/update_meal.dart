import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/meal_form_submission.dart';
import '../repositories/edit_meal_repository.dart';

@injectable
class UpdateMeal {
  UpdateMeal(this._repository);

  final EditMealRepository _repository;

  Future<Result<MealEntity>> call(
    String mealId,
    MealFormSubmission submission, {
    required bool isStopped,
  }) =>
      _repository.updateMeal(mealId, submission, isStopped: isStopped);
}
