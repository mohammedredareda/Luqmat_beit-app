import 'package:core/core.dart';

abstract class DeleteMealRepository {
  Future<Result<void>> deleteMeal(String mealId);
}
