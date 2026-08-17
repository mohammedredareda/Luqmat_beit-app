import 'package:hive_flutter/hive_flutter.dart';

import '../entities/meal_entity.dart';
import '../entities/selling_option_entity.dart';
import 'local_cache_box.dart';

/// Local, on-device index of favorited meals and followed cooks.
///
/// The backend has `POST`/`DELETE /user/customer/favorite` and `/follow`
/// (wired into `meal_details`/`chef_profile`) but no `GET` endpoint to list
/// either one — this is written to every time a favorite/follow toggle
/// succeeds, so the favorites/following screen has something real to show
/// instead of static sample data. It's a client-side mirror, not a source
/// of truth: a favorite/follow made on a different device or a fresh
/// install won't show up here until toggled again on this one — that gap
/// only closes once the backend adds real list endpoints.
///
/// Chefs are stored as plain maps rather than a typed entity because the
/// only chef summary shape (`ChefSummaryEntity`) lives in the app layer,
/// not `core` — `core` has zero knowledge of the app per the architecture
/// doc, so the app side does its own map<->entity conversion.
class FavoritesCache {
  static const _mealsKey = 'meals';
  static const _chefsKey = 'chefs';

  Box get _box => LocalCacheBox.box(LocalCacheBoxNames.favorites);

  List<MealEntity> readFavoriteMeals() {
    final raw = _box.get(_mealsKey, defaultValue: const []) as List;
    return raw.map((m) => _mealFromMap(Map<String, dynamic>.from(m as Map))).toList();
  }

  Future<void> addFavoriteMeal(MealEntity meal) async {
    final meals = readFavoriteMeals().where((m) => m.id != meal.id).toList()
      ..insert(0, meal);
    await _box.put(_mealsKey, meals.map(_mealToMap).toList());
  }

  Future<void> removeFavoriteMeal(String mealId) async {
    final meals = readFavoriteMeals().where((m) => m.id != mealId).toList();
    await _box.put(_mealsKey, meals.map(_mealToMap).toList());
  }

  List<Map<String, dynamic>> readFollowedChefs() {
    final raw = _box.get(_chefsKey, defaultValue: const []) as List;
    return raw.map((c) => Map<String, dynamic>.from(c as Map)).toList();
  }

  Future<void> addFollowedChef(Map<String, dynamic> chef) async {
    final chefs = readFollowedChefs().where((c) => c['id'] != chef['id']).toList()
      ..insert(0, chef);
    await _box.put(_chefsKey, chefs);
  }

  Future<void> removeFollowedChef(String chefId) async {
    final chefs = readFollowedChefs().where((c) => c['id'] != chefId).toList();
    await _box.put(_chefsKey, chefs);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Map<String, dynamic> _mealToMap(MealEntity meal) => {
        'id': meal.id,
        'cookId': meal.cookId,
        'cookName': meal.cookName,
        'cookAvatarUrl': meal.cookAvatarUrl,
        'name': meal.name,
        'description': meal.description,
        'imageUrl': meal.imageUrl,
        'rating': meal.rating,
        'ratingCount': meal.ratingCount,
        'isStopped': meal.isStopped,
        'sellingOptions': meal.sellingOptions
            .map((o) => {'id': o.id, 'label': o.label, 'price': o.price})
            .toList(),
        'singlePrice': meal.singlePrice,
        'preparingDurationMinutes': meal.preparingDurationMinutes,
      };

  MealEntity _mealFromMap(Map<String, dynamic> map) => MealEntity(
        id: map['id'] as String,
        cookId: map['cookId'] as String? ?? '',
        cookName: map['cookName'] as String? ?? '',
        cookAvatarUrl: map['cookAvatarUrl'] as String?,
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        imageUrl: map['imageUrl'] as String? ?? '',
        rating: (map['rating'] as num?)?.toDouble() ?? 0,
        ratingCount: (map['ratingCount'] as num?)?.toInt() ?? 0,
        isStopped: map['isStopped'] as bool? ?? false,
        isFavorite: true,
        sellingOptions: (map['sellingOptions'] as List? ?? const [])
            .map((o) => SellingOptionEntity(
                  id: (o as Map)['id'] as String,
                  label: o['label'] as String? ?? '',
                  price: (o['price'] as num?)?.toDouble() ?? 0,
                ))
            .toList(),
        singlePrice: (map['singlePrice'] as num?)?.toDouble(),
        preparingDurationMinutes: (map['preparingDurationMinutes'] as num?)?.toInt() ?? 0,
      );
}
