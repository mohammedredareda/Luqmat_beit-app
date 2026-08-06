import 'package:core/core.dart';

import '../../domain/entities/chef_profile_entity.dart';
import 'chef_data_source.dart';

/// Real implementation, backed by `GET /user/customer/cook/:id` and
/// `POST`/`DELETE /user/customer/follow`. The cook-info response has no
/// `bio`/`isFollowing`/`ratingCount` fields — left at empty/`false`/`0`
/// until the backend adds them.
class ChefRemoteDataSource implements ChefDataSource {
  ChefRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ChefProfileEntity> getChefProfile(String chefId) async {
    final json = await _apiClient.get('/user/customer/cook/$chefId') as Map;
    final menuJson = json['menu'] as List? ?? const [];

    return ChefProfileEntity(
      id: chefId,
      name: json['name'] as String? ?? '',
      avatarUrl: json['image'] as String? ?? '',
      bio: '',
      rating: (json['rate'] as num?)?.toDouble() ?? 0,
      ratingCount: 0,
      distanceKm: (json['distance'] as num?)?.toDouble() ?? 0,
      isFollowing: false,
      meals: menuJson.map((m) => _mealFromJson(m as Map, chefId, json)).toList(),
    );
  }

  MealEntity _mealFromJson(Map json, String chefId, Map cookJson) {
    final sellingOptionsJson = json['sellingOptions'] as List? ?? const [];
    return MealEntity(
      id: json['meal_id'].toString(),
      cookId: chefId,
      cookName: cookJson['name'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      rating: (json['rate'] as num?)?.toDouble() ?? 0,
      sellingOptions: sellingOptionsJson.map((so) {
        final option = so as Map;
        final type = option['type'] as String? ?? '';
        final variation = option['variation'] as String? ?? '';
        return SellingOptionEntity(
          id: option['selling_option_id'].toString(),
          label: [type, variation].where((s) => s.isNotEmpty).join(' - '),
          price: double.tryParse(option['price']?.toString() ?? '') ?? 0,
        );
      }).toList(),
    );
  }

  @override
  Future<void> toggleFollow(String chefId, {required bool wasFollowing}) async {
    final id = int.tryParse(chefId) ?? chefId;
    if (wasFollowing) {
      await _apiClient.delete('/user/customer/follow', data: {'cook_id': id});
    } else {
      await _apiClient.post('/user/customer/follow', data: {'cook_id': id});
    }
  }
}
