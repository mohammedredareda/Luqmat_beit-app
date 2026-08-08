import 'package:core/core.dart';

import 'search_data_source.dart';

/// Real implementation of `GET /user/customer/search`. `cursor` maps
/// directly to the backend's numeric `page` query param, and the response's
/// `next` page number becomes `nextCursor` — the backend's pagination is
/// page-based, not an opaque cursor, but this preserves
/// [SearchRepository]'s cursor-shaped contract for the rest of the app.
class SearchRemoteDataSource implements SearchDataSource {
  SearchRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResult<MealEntity>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final page = cursor == null ? 1 : int.tryParse(cursor) ?? 1;
    final (sortBy, sortOrder) = _mapSort(filters?['sort'] as String?);

    final response = await _apiClient.get('/user/customer/search', queryParameters: {
      'key': query,
      'page': page,
      'types': 'meals',
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
    });

    final mealsJson = (response as Map)['meals'] as List? ?? const [];
    final next = response['next'];

    return PaginatedResult<MealEntity>(
      items: mealsJson.map((m) => _mealFromJson(m as Map)).toList(),
      hasMore: next != null,
      nextCursor: next?.toString(),
    );
  }

  (String?, String?) _mapSort(String? sort) => switch (sort) {
        'topRated' => ('rating', 'desc'),
        'priceLowToHigh' => ('price', 'asc'),
        'priceHighToLow' => ('price', 'desc'),
        _ => (null, null),
      };

  MealEntity _mealFromJson(Map json) => MealEntity(
        id: json['meal_id'].toString(),
        cookId: json['cook_id']?.toString() ?? '',
        cookName: json['cook_name'] as String? ?? '',
        name: json['name'] as String? ?? '',
        description: '',
        imageUrl: json['image'] as String? ?? '',
        rating: (json['rate'] as num?)?.toDouble() ?? 0,
        isStopped: json['is_active'] == false,
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
