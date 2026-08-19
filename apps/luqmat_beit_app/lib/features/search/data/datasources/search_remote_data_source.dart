import 'package:core/core.dart';

import '../../domain/entities/search_result_item.dart';
import 'search_data_source.dart';

/// Real implementation of `GET /user/customer/search`. `cursor` maps
/// directly to the backend's numeric `page` query param, and the response's
/// `next` page number becomes `nextCursor` — the backend's pagination is
/// page-based, not an opaque cursor, but this preserves
/// [SearchRepository]'s cursor-shaped contract for the rest of the app.
///
/// `types` (comma-separated: `meals`, `offers`, `cooks`, `returned_meals`)
/// lets one page mix result kinds — the response can carry any combination
/// of `meals[]`/`offers[]`/`cooks[]`/`returned_meals[]`, all flattened into
/// one ordered [SearchResultItem] list (meals, then offers, then cooks,
/// then returned meals) so the rest of the app keeps using the shared
/// cursor-pagination infra unchanged.
class SearchRemoteDataSource implements SearchDataSource {
  SearchRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResult<SearchResultItem>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final page = cursor == null ? 1 : int.tryParse(cursor) ?? 1;
    final (sortBy, sortOrder) = _mapSort(filters?['sort'] as String?);
    final categoryId = filters?['categoryId'] as String?;
    final types = filters?['types'] as String? ?? 'meals';

    final response =
        await _apiClient.get('/user/customer/search', queryParameters: {
      'key': query,
      'page': page,
      'types': types,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (categoryId != null) 'category': categoryId,
    });

    final json = response as Map;
    final mealsJson = json['meals'] as List? ?? const [];
    final offersJson = json['offers'] as List? ?? const [];
    final cooksJson = json['cooks'] as List? ?? const [];
    final returnedMealsJson = json['returned_meals'] as List? ?? const [];
    final next = json['next'];

    final items = <SearchResultItem>[
      ...mealsJson.map((m) => SearchResultItem.meal(_mealFromJson(m as Map))),
      ...offersJson
          .map((o) => SearchResultItem.offer(_offerFromJson(o as Map))),
      ...cooksJson.map((c) => SearchResultItem.cook(_cookFromJson(c as Map))),
      ...returnedMealsJson.map((r) =>
          SearchResultItem.returnedMeal(_returnedMealFromJson(r as Map))),
    ];

    return PaginatedResult<SearchResultItem>(
      items: items,
      hasMore: next != null,
      nextCursor: next?.toString(),
    );
  }

  (String?, String?) _mapSort(String? sort) => switch (sort) {
        'topRated' => ('rating', 'desc'),
        'mostPopular' => ('top_selling', null),
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

  OfferBundleEntity _offerFromJson(Map json) {
    final mealsJson = json['meals'] as List? ?? const [];
    final expireTime = json['expire_time'] as String?;
    return OfferBundleEntity(
      id: json['offer_id'].toString(),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      totalPrice: double.tryParse(json['total_price']?.toString() ?? '') ?? 0,
      expireTime: expireTime != null
          ? DateTime.tryParse(expireTime) ?? DateTime.now()
          : DateTime.now(),
      meals: mealsJson.map((m) => _offerMealFromJson(m as Map)).toList(),
    );
  }

  OfferBundleMealEntity _offerMealFromJson(Map json) => OfferBundleMealEntity(
        mealId: json['meal_id'].toString(),
        name: json['name'] as String? ?? '',
        imageUrl: json['image'] as String? ?? '',
        variationLabel: json['variation_quantity'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        finalPrice: (json['final_price'] as num?)?.toDouble() ??
            (json['price'] as num?)?.toDouble() ??
            0,
      );

  ChefSummaryEntity _cookFromJson(Map json) => ChefSummaryEntity(
        id: json['cook_id'].toString(),
        name: json['name'] as String? ?? '',
        avatarUrl: json['image'] as String? ?? '',
        rating: (json['rate'] as num?)?.toDouble() ?? 0,
        ratingCount: 0,
        distanceKm: (json['distance'] as num?)?.toDouble() ?? 0,
      );

  ReturnedMealEntity _returnedMealFromJson(Map json) {
    final meal = json['meal'] as Map? ?? const {};
    final sellingOption = json['selling_option'] as Map? ?? const {};
    final expiryTime = json['expiry_time'] as String?;
    return ReturnedMealEntity(
      id: json['returned_meal_id'].toString(),
      originalItemId: '',
      mealId: meal['meal_id'].toString(),
      mealName: meal['name'] as String? ?? '',
      imageUrl: meal['image'] as String? ?? '',
      originalPrice: (meal['price'] as num?)?.toDouble() ?? 0,
      salvagePrice: (meal['salvage_price'] as num?)?.toDouble() ?? 0,
      expiryTime: expiryTime != null
          ? DateTime.tryParse(expiryTime) ?? DateTime.now()
          : DateTime.now(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      sellingOptionId: sellingOption['selling_option_id']?.toString(),
    );
  }
}
