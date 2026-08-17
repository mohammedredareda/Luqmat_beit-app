import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../../shared/domain/entities/short_management_entity.dart';
import '../../domain/usecases/get_my_shorts.dart';
import 'view_shorts_state.dart';

/// "My Shorts" gallery (mockup `_4`) — a single fetch-and-display flow,
/// matching `ViewMenuCubit`/`ViewOffersCubit`. Paginated via
/// [PaginationStateMixin].
class ViewShortsCubit extends Cubit<ViewShortsState>
    with PaginationStateMixin<ShortManagementEntity> {
  ViewShortsCubit(this._getMyShorts) : super(const ViewShortsState.initial());

  final GetMyShorts _getMyShorts;

  Future<void> load() async {
    resetPagination();
    emit(const ViewShortsState.loading());
    final result = await _getMyShorts(currentCookId);
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewShortsState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) => emit(ViewShortsState.error(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;
    isLoadingMore = true;
    emit(ViewShortsState.loaded(items: items, hasMore: hasMore, isLoadingMore: true));
    final result = await _getMyShorts(currentCookId, cursor: cursor);
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewShortsState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) {
        isLoadingMore = false;
        emit(ViewShortsState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
    );
  }

  /// Drops the item by id without refetching (mirrors
  /// `ViewOffersCubit.removeItem`) — a re-fetch right after a successful
  /// delete could still return the just-deleted item if the fake "backend"
  /// state read raced the write.
  void removeItem(String id) {
    if (state is! ViewShortsLoaded) return;
    items = items.where((item) => item.id != id).toList();
    emit(ViewShortsState.loaded(items: items, hasMore: hasMore, isLoadingMore: isLoadingMore));
  }
}
