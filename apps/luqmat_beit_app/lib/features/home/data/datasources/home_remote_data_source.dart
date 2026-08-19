import 'package:core/core.dart';

import '../../domain/entities/home_feed_entity.dart';
import 'home_data_source.dart';

/// Real implementation. There is no single "home feed" endpoint in the
/// backend (`AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`) — this
/// fans out to `/user/customer/categories`, `/user/customer/get-cook`,
/// `/user/customer/offers`, `/user/customer/search` (sorted by
/// `top_selling`, for `bestSellers`), and `/user/customer/returned-meals`,
/// and assembles [HomeFeedEntity] client-side. `/user/customer/ads` has no
/// field to land in on this entity (no example response either) and is
/// intentionally not called.
class HomeRemoteDataSource implements HomeDataSource {
  HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<HomeFeedEntity> getHomeFeed() async {
    final results = await Future.wait([
      _apiClient.get('/user/customer/categories'),
      _apiClient.get('/user/customer/get-cook'),
      _apiClient.get('/user/customer/offers'),
      _apiClient.get('/user/customer/search', queryParameters: {
        'key': '',
        'page': 1,
        'types': 'meals',
        'sort_by': 'top_selling',
      }),
      _apiClient.get('/user/customer/returned-meals'),
    ]);

    final categoriesJson =
        (results[0] as Map)['categories'] as List? ?? const [];
    final cooksJson = (results[1] as Map)['cooks'] as List? ?? const [];
    final offersJson = (results[2] as Map)['offers'] as List? ?? const [];
    final discountsJson = (results[2] as Map)['discounts'] as List? ?? const [];
    final bestSellersJson = (results[3] as Map)['meals'] as List? ?? const [];
    final returnedMealsJson =
        (results[4] as Map)['returned_meals'] as List? ?? const [];

    return HomeFeedEntity(
      categories:
          categoriesJson.map((c) => _categoryFromJson(c as Map)).toList(),
      bestSellers:
          bestSellersJson.map((m) => _bestSellerFromJson(m as Map)).toList(),
      chefs: cooksJson.map((c) => _chefFromJson(c as Map)).toList(),
      offerBundles:
          offersJson.map((o) => _offerBundleFromJson(o as Map)).toList(),
      discountedMeals:
          discountsJson.map((d) => _mealFromDiscountJson(d as Map)).toList(),
      discountsByMealId: {
        for (final d in discountsJson)
          _discountFromJson(d as Map).mealId: _discountFromJson(d),
      },
      returnedMeals: returnedMealsJson
          .map((r) => _returnedMealFromJson(r as Map))
          .toList(),
    );
  }

  MealEntity _bestSellerFromJson(Map json) => MealEntity(
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

  OfferBundleEntity _offerBundleFromJson(Map json) {
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
      meals: mealsJson.map((m) => _offerBundleMealFromJson(m as Map)).toList(),
    );
  }

  OfferBundleMealEntity _offerBundleMealFromJson(Map json) =>
      OfferBundleMealEntity(
        mealId: json['meal_id'].toString(),
        name: json['name'] as String? ?? '',
        imageUrl: json['image'] as String? ?? '',
        variationLabel: json['variation_quantity'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        finalPrice: (json['final_price'] as num?)?.toDouble() ??
            (json['price'] as num?)?.toDouble() ??
            0,
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
      discountPercentage:
          double.tryParse(json['discount_percentage']?.toString() ?? '') ?? 0,
      discountDurationDays: durationDays ?? 0,
      createdAt: DateTime.now(),
      expiryTime: end,
    );
  }
}
