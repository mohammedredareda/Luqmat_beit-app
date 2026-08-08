import 'package:core/core.dart';

import '../../domain/entities/home_feed_entity.dart';
import 'home_data_source.dart';

/// Real implementation. There is no single "home feed" endpoint in the
/// backend (`AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`) — this
/// fans out to `/user/customer/categories`, `/user/customer/get-cook`, and
/// `/user/customer/offers` and assembles [HomeFeedEntity] client-side.
/// `/user/customer/ads` has no field to land in on this entity (no example
/// response either) and is intentionally not called. `bestSellers` also has
/// no matching endpoint — left empty rather than guessed.
class HomeRemoteDataSource implements HomeDataSource {
  HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<HomeFeedEntity> getHomeFeed() async {
    final results = await Future.wait([
      _apiClient.get('/user/customer/categories'),
      _apiClient.get('/user/customer/get-cook'),
      _apiClient.get('/user/customer/offers'),
    ]);

    final categoriesJson = (results[0] as Map)['categories'] as List? ?? const [];
    final cooksJson = (results[1] as Map)['cooks'] as List? ?? const [];
    final discountsJson = (results[2] as Map)['discounts'] as List? ?? const [];

    return HomeFeedEntity(
      categories: categoriesJson.map((c) => _categoryFromJson(c as Map)).toList(),
      bestSellers: const [],
      chefs: cooksJson.map((c) => _chefFromJson(c as Map)).toList(),
      // The backend's "offers" are multi-meal bundles, which don't fit
      // HomeFeedEntity.offers's `List<MealEntity>` shape — left empty rather
      // than misrepresenting a bundle as a single meal.
      offers: const [],
      bigDiscounts: discountsJson.map((d) => _mealFromDiscountJson(d as Map)).toList(),
      discountsByMealId: {
        for (final d in discountsJson) _discountFromJson(d as Map).mealId: _discountFromJson(d),
      },
    );
  }

  CategoryEntity _categoryFromJson(Map json) => CategoryEntity(
        id: json['category_id'].toString(),
        label: json['name'] as String? ?? '',
        // Backend sends an image URL, not one of the app's local icon-name
        // keys (see CategoryChip) — fall back to the default icon.
        iconName: 'restaurant',
      );

  ChefSummaryEntity _chefFromJson(Map json) => ChefSummaryEntity(
        id: json['cook_id'].toString(),
        name: json['name'] as String? ?? '',
        avatarUrl: json['image'] as String? ?? '',
        rating: (json['rate'] as num?)?.toDouble() ?? 0,
        ratingCount: 0,
        distanceKm: (json['distance'] as num?)?.toDouble() ?? 0,
      );

  MealEntity _mealFromDiscountJson(Map json) {
    final meal = json['meal'] as Map? ?? const {};
    return MealEntity(
      id: meal['meal_id'].toString(),
      cookId: '',
      cookName: '',
      name: meal['name'] as String? ?? '',
      description: '',
      imageUrl: meal['image'] as String? ?? '',
      sellingOptions: [
        SellingOptionEntity(
          id: 'default',
          label: '',
          price: (meal['discounted_price'] as num?)?.toDouble() ??
              (meal['price'] as num?)?.toDouble() ??
              0,
        ),
      ],
    );
  }

  DiscountEntity _discountFromJson(Map json) {
    final meal = json['meal'] as Map? ?? const {};
    final expireTime = json['expire_time'] as String?;
    final durationDays = json['discount_duration'] as int?;
    final end = expireTime != null
        ? DateTime.tryParse(expireTime) ?? DateTime.now()
        : DateTime.now().add(Duration(days: durationDays ?? 0));
    return DiscountEntity(
      id: json['discount_id'].toString(),
      mealId: meal['meal_id'].toString(),
      discountPercentage: double.tryParse(json['discount_percentage']?.toString() ?? '') ?? 0,
      discountDurationDays: durationDays ?? 0,
      createdAt: DateTime.now(),
      expiryTime: end,
    );
  }
}
