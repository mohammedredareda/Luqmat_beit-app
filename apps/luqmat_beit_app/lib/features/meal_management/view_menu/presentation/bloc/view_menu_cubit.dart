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
}
