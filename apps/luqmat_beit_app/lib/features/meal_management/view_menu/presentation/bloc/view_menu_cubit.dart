import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_my_meals.dart';
import 'view_menu_state.dart';

/// CK-06 View My Menu — a single fetch-and-display flow (loading/loaded/
/// error, no branching outcomes), which is exactly the criterion the
/// architecture doc uses to pick Cubit over Bloc. Paginated via
/// [PaginationStateMixin]: `loadMenu` resets to page one, `loadMore`
/// fetches the next page.
class ViewMenuCubit extends Cubit<ViewMenuState> with PaginationStateMixin<MealEntity> {
  ViewMenuCubit(this._getMyMeals) : super(const ViewMenuState.initial());

  final GetMyMeals _getMyMeals;

  bool _isSellingPaused = false;

  Future<void> loadMenu() async {
    resetPagination();
    emit(const ViewMenuState.loading());
    final result = await _getMyMeals(currentCookId);
    result.fold(
      (data) {
        appendPage(data.page);
        _isSellingPaused = data.isSellingPaused;
        emit(ViewMenuState.loaded(
          meals: items,
          isSellingPaused: _isSellingPaused,
          hasMore: hasMore,
          isLoadingMore: false,
        ));
      },
      (exception) => emit(ViewMenuState.error(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;
    isLoadingMore = true;
    emit(ViewMenuState.loaded(
      meals: items,
      isSellingPaused: _isSellingPaused,
      hasMore: hasMore,
      isLoadingMore: true,
    ));
    final result = await _getMyMeals(currentCookId, cursor: cursor);
    result.fold(
      (data) {
        appendPage(data.page);
        _isSellingPaused = data.isSellingPaused;
        emit(ViewMenuState.loaded(
          meals: items,
          isSellingPaused: _isSellingPaused,
          hasMore: hasMore,
          isLoadingMore: false,
        ));
      },
      (exception) {
        isLoadingMore = false;
        emit(ViewMenuState.loaded(
          meals: items,
          isSellingPaused: _isSellingPaused,
          hasMore: hasMore,
          isLoadingMore: false,
        ));
      },
    );
  }

  /// The Edit/Delete Meal screens return the updated [MealEntity] (or the
  /// deleted meal's id) straight from their `Result`, so the dashboard can
  /// reflect the change immediately — a `loadMenu()` refetch would be
  /// redundant round-trip latency for data this screen already has in
  /// hand. Creation deliberately has no equivalent `addMeal`: the backend's
  /// create response carries no meal data at all (see
  /// `MealRemoteDataSource.createMeal`'s comment) — no server id, no
  /// hosted image URL — so there's nothing accurate to add optimistically;
  /// `view_menu_page.dart` still calls `loadMenu()` after a create.
  void replaceMeal(MealEntity meal) {
    if (state is! ViewMenuLoaded) return;
    items = [for (final m in items) if (m.id == meal.id) meal else m];
    emit(ViewMenuState.loaded(
      meals: items,
      isSellingPaused: _isSellingPaused,
      hasMore: hasMore,
      isLoadingMore: isLoadingMore,
    ));
  }

  void removeMeal(String mealId) {
    if (state is! ViewMenuLoaded) return;
    items = items.where((m) => m.id != mealId).toList();
    emit(ViewMenuState.loaded(
      meals: items,
      isSellingPaused: _isSellingPaused,
      hasMore: hasMore,
      isLoadingMore: isLoadingMore,
    ));
  }
}
