import 'package:core/core.dart';

import '../repositories/meal_details_repository.dart';

class ReportMeal {
  const ReportMeal(this._repository);

  final MealDetailsRepository _repository;

  Future<Result<void>> call(String mealId, String message) {
    return _repository.reportMeal(mealId, message);
  }
}
