import 'package:core/core.dart';

import '../../../home/domain/entities/home_feed_entity.dart';

/// The backend has `POST`/`DELETE /user/customer/favorite` and `/follow`
/// (wired into `meal_details`/`chef_profile`) but no `GET` endpoint to list
/// either one — this reads the local mirror [FavoritesCache] keeps in sync
/// with every toggle made elsewhere in the app, and calls the same
/// unfavorite/unfollow endpoints those screens use so removing an item here
/// actually un-favorites/unfollows it server-side too, not just locally.
class FavoritesLocalDataSource {
  FavoritesLocalDataSource(this._apiClient, this._favoritesCache);

  final ApiClient _apiClient;
  final FavoritesCache _favoritesCache;

  Future<List<MealEntity>> getFavoriteMeals() async => _favoritesCache.readFavoriteMeals();

  Future<List<ChefSummaryEntity>> getFollowedChefs() async {
    return _favoritesCache.readFollowedChefs().map((map) {
      return ChefSummaryEntity(
        id: map['id'] as String,
        name: map['name'] as String? ?? '',
        avatarUrl: map['avatarUrl'] as String? ?? '',
        rating: (map['rating'] as num?)?.toDouble() ?? 0,
        ratingCount: (map['ratingCount'] as num?)?.toInt() ?? 0,
        distanceKm: (map['distanceKm'] as num?)?.toDouble() ?? 0,
      );
    }).toList();
  }

  Future<void> unfavoriteMeal(String mealId) async {
    final id = int.tryParse(mealId) ?? mealId;
    await _apiClient.delete('/user/customer/favorite', data: {'meal_id': id});
    await _favoritesCache.removeFavoriteMeal(mealId);
  }

  Future<void> unfollowChef(String chefId) async {
    final id = int.tryParse(chefId) ?? chefId;
    await _apiClient.delete('/user/customer/follow', data: {'cook_id': id});
    await _favoritesCache.removeFollowedChef(chefId);
  }
}
