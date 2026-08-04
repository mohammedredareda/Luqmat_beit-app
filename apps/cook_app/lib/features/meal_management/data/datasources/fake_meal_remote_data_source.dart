import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/meal_model.dart';
import '../models/selling_option_model.dart';

/// In-memory stand-in for the real Dio-backed data source — no backend
/// exists yet. Swapping this for a real `MealRemoteDataSource` later
/// requires no changes above this file: repositories, domain, and
/// presentation layers only ever see the feature repository interfaces /
/// `Result<T>`. Shared as one `@lazySingleton` instance across every
/// meal_management feature (view_menu, create_meal, edit_meal,
/// delete_meal) so they all mutate the same in-memory list.
@lazySingleton
class FakeMealRemoteDataSource {
  FakeMealRemoteDataSource() : _meals = List.of(_seed());

  final List<MealModel> _meals;

  /// Mirrors `COOK.isActive` — flipped by CK-10's Stop Selling switch.
  bool _cookIsActive = true;

  static List<MealModel> _seed() => const [
        MealModel(
          id: 'meal-1',
          cookId: currentCookId,
          name: 'كبسة دجاج منزلية',
          description: 'أرز بسمتي مع دجاج متبل وتوابل الكبسة التقليدية',
          price: 45,
          imageUrl: 'https://picsum.photos/seed/kabsa/200/200',
          isActive: true,
        ),
        MealModel(
          id: 'meal-2',
          cookId: currentCookId,
          name: 'فطائر لحم بالفرن',
          description: 'عجينة منزلية محشوة بلحم مفروم وبصل وتوابل',
          price: null,
          sellingOptions: [
            SellingOptionModel(id: 'meal-2-opt-1', label: 'صغير', price: 15),
            SellingOptionModel(id: 'meal-2-opt-2', label: 'وسط', price: 25),
            SellingOptionModel(id: 'meal-2-opt-3', label: 'كبير', price: 35),
          ],
          imageUrl: 'https://picsum.photos/seed/fatayer/200/200',
          isActive: true,
        ),
        MealModel(
          id: 'meal-3',
          cookId: currentCookId,
          name: 'شوربة عدس',
          description: 'شوربة عدس أحمر كريمية مع الليمون والكمون',
          price: 15,
          imageUrl: 'https://picsum.photos/seed/lentil/200/200',
          isActive: false,
        ),
        MealModel(
          id: 'meal-4',
          cookId: currentCookId,
          name: 'مسقعة باذنجان',
          description: 'باذنجان مقلي مع صلصة الطماطم والثوم',
          price: 25,
          imageUrl: 'https://picsum.photos/seed/moussaka/200/200',
          isActive: true,
        ),
        MealModel(
          id: 'meal-5',
          cookId: currentCookId,
          name: 'كنافة بالجبن',
          description: 'كنافة ناعمة محشوة بالجبن ومغطاة بالقطر',
          price: 20,
          imageUrl: 'https://picsum.photos/seed/kunafa/200/200',
          isActive: true,
        ),
      ];

  /// Returns each meal with its *effective* isActive: the meal's own
  /// state, AND NOT stopped (CK-24), AND the cook's kitchen-wide state —
  /// never mutates the meal's own intrinsic state, so re-enabling selling
  /// doesn't resurrect a meal that's independently inactive (CK-10's
  /// business rule). Soft-deleted meals (CK-09) are excluded entirely.
  Future<List<MealModel>> getMyMeals(String cookId) async {
    return _meals
        .where((m) => m.cookId == cookId && m.deletedAt == null)
        .map((m) => m.copyWith(isActive: m.isActive && !m.isStopped && _cookIsActive))
        .toList(growable: false);
  }

  Future<MealModel?> getMealById(String id) async {
    for (final meal in _meals) {
      if (meal.id == id && meal.deletedAt == null) return meal;
    }
    return null;
  }

  Future<MealModel> createMeal(MealModel meal) async {
    _meals.add(meal);
    return meal;
  }

  Future<MealModel> updateMeal(MealModel meal) async {
    final index = _meals.indexWhere((m) => m.id == meal.id);
    if (index == -1) throw const NotFoundException('Meal not found');
    return _meals[index] = meal;
  }

  /// CK-09 soft delete — sets [MealModel.deletedAt], never flips
  /// [MealModel.isActive] (that stays derived, see [getMyMeals]).
  ///
  /// TODO(CK-08/CK-09 order-blocking): before soft-deleting, the backlog
  /// requires checking whether the meal has any Pending/Accepted/
  /// Preparing order (Case A blocks outright; Case B — Pending-only —
  /// offers a bulk Accept-All/Reject-All resolve popup). Deferred until
  /// an Orders feature (CK-18) exists to query order status against —
  /// today this always proceeds straight to soft-delete.
  Future<void> deleteMeal(String id) async {
    final index = _meals.indexWhere((m) => m.id == id);
    if (index == -1) throw const NotFoundException('Meal not found');
    _meals[index] = _meals[index].copyWith(deletedAt: DateTime.now());
  }

  Future<bool> isSellingPaused(String cookId) async => !_cookIsActive;

  /// Returns the resulting `isSellingPaused` value, echoing what the
  /// real API would confirm back after the write.
  Future<bool> setSellingPaused(String cookId, bool isPaused) async {
    _cookIsActive = !isPaused;
    return isPaused;
  }
}
