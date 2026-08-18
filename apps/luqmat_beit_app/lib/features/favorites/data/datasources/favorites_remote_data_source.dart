import 'package:core/core.dart';

import '../../../home/domain/entities/home_feed_entity.dart';

/// Real implementation, backed by `GET /user/customer/favorites` and
/// `GET /user/customer/follows` (added after `POST`/`DELETE` had been the
/// only endpoints for a while — this replaces the local-cache mirror that
/// stood in for them until then). Only fetches the first page — the
/// favorites/follows screen has no pagination UI today, same as when it
/// read from the local mirror.
class FavoritesRemoteDataSource {
  FavoritesRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<MealEntity>> getFavoriteMeals() async {
    final response = await _apiClient.get('/user/customer/favorites');
    final itemsJson = (response as Map)['favorites'] as List? ?? const [];
    return itemsJson.map((i) => _mealFromJson(i as Map)).toList();
  }

  Future<List<ChefSummaryEntity>> getFollowedChefs() async {
    final response = await _apiClient.get('/user/customer/follows');
    final itemsJson = (response as Map)['cooks'] as List? ?? const [];
    return itemsJson.map((i) => _chefFromJson(i as Map)).toList();
  }

  Future<void> unfavoriteMeal(String mealId) async {
    final id = int.tryParse(mealId) ?? mealId;
    await _apiClient.delete('/user/customer/favorite', data: {'meal_id': id});
  }

  Future<void> unfollowChef(String chefId) async {
    final id = int.tryParse(chefId) ?? chefId;
    await _apiClient.delete('/user/customer/follow', data: {'cook_id': id});
  }

  MealEntity _mealFromJson(Map json) {
    final cook = json['cook'] as Map? ?? const {};
    return MealEntity(
      id: json['meal_id'].toString(),
      cookId: cook['cook_id']?.toString() ?? '',
      cookName: cook['name'] as String? ?? '',
      cookAvatarUrl: cook['image'] as String?,
      name: json['name'] as String? ?? '',
      description: '',
      imageUrl: json['image'] as String? ?? '',
      rating: (json['rate'] as num?)?.toDouble() ?? 0,
      isStopped: json['is_active'] == false,
      isFavorite: true,
      sellingOptions: [
        SellingOptionEntity(
          id: 'default',
          label: '',
          price: (json['final_price'] as num?)?.toDouble() ??
              (json['price'] as num?)?.toDouble() ??
              0,
        ),
      ],
    );
  }

  ChefSummaryEntity _chefFromJson(Map json) => ChefSummaryEntity(
        id: json['cook_id'].toString(),
        name: json['name'] as String? ?? '',
        avatarUrl: json['image'] as String? ?? '',
        rating: (json['rate'] as num?)?.toDouble() ?? 0,
        ratingCount: 0,
        distanceKm: (json['distance'] as num?)?.toDouble() ?? 0,
      );
}
