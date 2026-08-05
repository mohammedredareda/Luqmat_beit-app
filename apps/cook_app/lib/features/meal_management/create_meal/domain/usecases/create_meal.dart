import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/meal_form_submission.dart';
import '../repositories/create_meal_repository.dart';

@injectable
class CreateMeal {
  CreateMeal(this._repository);

  final CreateMealRepository _repository;

  Future<Result<MealEntity>> call(MealFormSubmission submission) =>
      _repository.createMeal(submission);
}
