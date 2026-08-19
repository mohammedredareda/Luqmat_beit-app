import 'package:core/core.dart';


abstract class FavoritesRepository {
  Future<Result<List<MealEntity>>> getFavoriteMeals();

  Future<Result<List<ChefSummaryEntity>>> getFollowedChefs();

  Future<Result<void>> unfavoriteMeal(String mealId);

  Future<Result<void>> unfollowChef(String chefId);
}
