import '../../../../shared/mock/sample_catalog.dart';
import '../../../home/domain/entities/home_feed_entity.dart';
import 'package:core/core.dart';

/// Stands in for `favorites_remote_data_source.dart` until a backend
/// exists. Mutates the shared in-memory `SampleCatalog` lists so the
/// unfavorite/unfollow toggle sticks for the lifetime of the process, same
/// as a real API would persist it server-side.
///
/// TODO(backend): the collection has `POST`/`DELETE /user/customer/favorite`
/// and `/follow` (wired into `meal_details`/`chef_profile`), but no `GET`
/// endpoint to list favorited meals or followed chefs — this screen stays
/// mocked until one exists.
class FavoritesMockDataSource {
  final List<MealEntity> _favoriteMeals = SampleCatalog.meals.take(3).toList();
  final List<ChefSummaryEntity> _followedChefs = List.of(SampleCatalog.chefs);

  Future<List<MealEntity>> getFavoriteMeals() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_favoriteMeals);
  }

  Future<List<ChefSummaryEntity>> getFollowedChefs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_followedChefs);
  }

  Future<void> unfavoriteMeal(String mealId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _favoriteMeals.removeWhere((meal) => meal.id == mealId);
  }

  Future<void> unfollowChef(String chefId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _followedChefs.removeWhere((chef) => chef.id == chefId);
  }
}
