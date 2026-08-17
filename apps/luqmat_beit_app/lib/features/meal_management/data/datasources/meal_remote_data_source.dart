import 'package:core/core.dart';
import 'package:dio/dio.dart' show MultipartFile;

import '../models/meal_model.dart';

/// Real Dio-backed data source for the Cook Meal Management endpoints —
/// replaces `FakeMealRemoteDataSource`. Shared as one instance across
/// view_menu/create_meal/edit_meal/delete_meal, same as the fake it
/// replaces, though nothing here holds mutable state (the "backend" is now
/// the real server).
class MealRemoteDataSource {
  MealRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  /// CK-06's paginated menu listing (`GET /user/cook/menu/meals?page=N`).
  /// The docs' own schema for this response is a placeholder
  /// (`{meals: {meal-infos}}`) — this defensively accepts either a `data`
  /// list with a `meta` envelope (matching the confirmed `my-promotions`
  /// shape) or a flat `meals` list, and falls back to inferring
  /// `hasNextPage` from a full page when no `meta` is present.
  Future<PaginatedResult<MealModel>> getMyMeals(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final page = cursor == null ? 1 : int.parse(cursor);
    final response = await _apiClient.get(
      '/user/cook/menu/meals',
      queryParameters: {'page': page},
    ) as Map;

    final rawList = response['data'] ?? response['meals'];
    final mealsJson = rawList is List ? rawList : const [];
    final meals =
        mealsJson.map((m) => MealModel.fromApiJson((m as Map).cast<String, dynamic>())).toList();

    final meta = response['meta'] as Map?;
    final hasNextPage =
        meta != null ? (meta['hasNextPage'] as bool? ?? false) : meals.length >= pageSize;

    return PaginatedResult(
      items: meals,
      hasMore: hasNextPage,
      nextCursor: hasNextPage ? (page + 1).toString() : null,
    );
  }

  /// No unpaginated "all meals" endpoint is documented — pages through
  /// [getMyMeals] until exhausted, for callers (e.g. the offer/discount
  /// "pick a meal" popup) that need the full list at once.
  Future<List<MealModel>> getAllMyMeals(String cookId) async {
    final all = <MealModel>[];
    String? cursor;
    while (true) {
      final page = await getMyMeals(cookId, cursor: cursor);
      all.addAll(page.items);
      if (!page.hasMore) break;
      cursor = page.nextCursor;
    }
    return all;
  }

  /// TODO(backend): no documented `GET .../meals/{id}` — falls back to
  /// paging through the full menu and filtering client-side.
  Future<MealModel?> getMealById(String id) async {
    final all = await getAllMyMeals('');
    for (final meal in all) {
      if (meal.id == id) return meal;
    }
    return null;
  }

  Future<MealModel> createMeal(MealModel meal) async {
    final fields = await _multipartFields(meal);
    await _apiClient.post('/user/cook/menu/meals/create', data: fields, isFormData: true);
    // 201 response is only `{message: "created successfully"}` — no created
    // meal payload, so no server-generated id to read back. Callers (the
    // create-meal form) only care whether this succeeded — they navigate
    // away and the menu list re-fetches the real record on return.
    return meal;
  }

  Future<MealModel> updateMeal(MealModel meal) async {
    final fields = await _multipartFields(meal);
    final response = await _apiClient.put(
      '/user/cook/menu/meals/${meal.id}',
      data: fields,
      isFormData: true,
    );
    final body = (response as Map)['data'];
    return body is Map ? MealModel.fromApiJson(body.cast<String, dynamic>()) : meal;
  }

  /// Per-meal status flip (`PATCH .../meals/{id}/toggle-status`) — the real
  /// API's `PUT .../meals/{id}` has no active/stopped field at all, so
  /// [EditMealRepositoryImpl] calls this separately when the cook's
  /// isAvailable switch differs from the meal's current server state.
  /// Returns the resulting `isActive`.
  Future<bool> toggleMealStatus(String id) async {
    final response = await _apiClient.patch('/user/cook/menu/meals/$id/toggle-status');
    return (response as Map)['isActive'] as bool? ?? false;
  }

  Future<void> deleteMeal(String id) async {
    await _apiClient.delete('/user/cook/menu/meals/$id');
  }

  /// Kitchen-wide selling flag — confirmed live at `GET /users/profile`
  /// (`user.isActive`), the same field `PATCH .../profile/toggle-selling`
  /// below writes. `isActive: true` means selling is on, so "paused" is
  /// the inverse.
  Future<bool> isSellingPaused(String cookId) async {
    final response = await _apiClient.get('/users/profile') as Map;
    final user = (response['user'] as Map?)?.cast<String, dynamic>();
    final isActive = user?['isActive'] as bool? ?? true;
    return !isActive;
  }

  /// `PATCH /user/cook/profile/toggle-selling` — confirmed live:
  /// `{"isActive": bool}` in, `{"message", "data": {"isActive": bool}}`
  /// out. Returns the resulting `isSellingPaused` value from the response,
  /// not just an echo of what was requested.
  Future<bool> setSellingPaused(String cookId, bool isPaused) async {
    final response = await _apiClient.patch(
      '/user/cook/profile/toggle-selling',
      data: {'isActive': !isPaused},
    ) as Map;
    final data = (response['data'] as Map?)?.cast<String, dynamic>();
    final isActive = data?['isActive'] as bool? ?? !isPaused;
    return !isActive;
  }

  Future<Map<String, dynamic>> _multipartFields(MealModel meal) async {
    final fields = meal.toApiRequestFields();
    if (meal.imageUrl.isNotEmpty && !_isRemoteUrl(meal.imageUrl)) {
      fields['image'] = await MultipartFile.fromFile(meal.imageUrl);
    }
    return fields;
  }

  bool _isRemoteUrl(String path) => path.startsWith('http://') || path.startsWith('https://');
}
