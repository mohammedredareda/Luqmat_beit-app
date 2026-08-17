import 'package:core/core.dart';

/// Real Dio-backed data source for `GET /user/customer/categories`. Shared
/// infra despite the URL's `customer` segment — same catalog serves the
/// cook meal-creation category picker too, see [FoodCategoryEntity].
class CategoriesRemoteDataSource {
  CategoriesRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<FoodCategoryEntity>> getCategories() async {
    final response = await _apiClient.get('/user/customer/categories');
    final categoriesJson = (response as Map)['categories'] as List? ?? const [];
    return categoriesJson.map((c) => _fromJson(c as Map)).toList();
  }

  FoodCategoryEntity _fromJson(Map json) {
    final subcategoriesJson = json['subcategories'] as List? ?? const [];
    return FoodCategoryEntity(
      id: json['category_id'].toString(),
      name: json['name'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      subcategories: subcategoriesJson.map((c) => _fromJson(c as Map)).toList(),
    );
  }
}
