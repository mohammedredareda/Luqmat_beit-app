import 'package:core/core.dart';

abstract class MealDetailsDataSource {
  Future<MealEntity> getMealById(String mealId);

  Future<void> setFavorite(String mealId, bool isFavorite);

  Future<void> reportMeal(String mealId, String message);
}
