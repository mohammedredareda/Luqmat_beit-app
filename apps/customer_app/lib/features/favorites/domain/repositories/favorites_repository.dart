import 'package:core/core.dart';

import '../../../home/domain/entities/home_feed_entity.dart';

abstract class FavoritesRepository {
  Future<Result<List<MealEntity>>> getFavoriteMeals();

  Future<Result<List<ChefSummaryEntity>>> getFollowedChefs();

  Future<Result<void>> unfavoriteMeal(String mealId);

  Future<Result<void>> unfollowChef(String chefId);
}
