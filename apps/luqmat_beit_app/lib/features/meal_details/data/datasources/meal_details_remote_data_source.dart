import 'package:core/core.dart';

import 'meal_details_data_source.dart';

/// Real implementation, backed by `GET /user/customer/meal/:id` and
/// `POST`/`DELETE /user/customer/favorite`.
class MealDetailsRemoteDataSource implements MealDetailsDataSource {
  MealDetailsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<MealEntity> getMealById(String mealId) async {
    final json = await _apiClient.get('/user/customer/meal/$mealId') as Map;
    final cook = json['cook'] as Map? ?? const {};
    final sellingOptionsJson = json['selling_options'] as List? ?? const [];

    return MealEntity(
      id: json['id'].toString(),
      cookId: cook['id']?.toString() ?? '',
      cookName: cook['name'] as String? ?? '',
      cookAvatarUrl: cook['image'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      rating: (json['rate'] as num?)?.toDouble() ?? 0,
      isStopped: json['is_active'] == false,
      sellingOptions: sellingOptionsJson.map((so) {
        final option = so as Map;
        final type = option['type'] as String? ?? '';
        final variation = option['variation'] as String? ?? '';
        return SellingOptionEntity(
          id: option['selling_option_id'].toString(),
          label: [type, variation].where((s) => s.isNotEmpty).join(' - '),
          price: (option['final_price'] as num?)?.toDouble() ??
              (option['price'] as num?)?.toDouble() ??
              0,
        );
      }).toList(),
    );
  }

  @override
  Future<void> setFavorite(String mealId, bool isFavorite) async {
    final id = int.tryParse(mealId) ?? mealId;
    if (isFavorite) {
      await _apiClient.post('/user/customer/favorite', data: {'meal_id': id});
    } else {
      await _apiClient.delete('/user/customer/favorite', data: {'meal_id': id});
    }
  }
}
