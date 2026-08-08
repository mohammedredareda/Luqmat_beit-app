import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_orders.dart';
import 'view_orders_state.dart';

/// CK-16 View My Orders — a single fetch-and-display flow per filter
/// (loading/loaded/error, no branching outcomes), same Cubit-over-Bloc
/// reasoning as `ViewMenuCubit`. Paginated via [PaginationStateMixin]:
/// `loadOrders` resets to page one (also on a filter change, never
/// appending onto a stale list), `loadMore` fetches the next page.
class ViewOrdersCubit extends Cubit<ViewOrdersState> with PaginationStateMixin<OrderEntity> {
  ViewOrdersCubit(this._getOrders) : super(const ViewOrdersState.initial());

  final GetOrders _getOrders;

  /// Guards against a slower earlier request (e.g. a fast double tab
  /// switch) overwriting the result of a later one.
  int _requestId = 0;

  OrderStatus? _statusFilter;

  Future<void> loadOrders(OrderStatus? statusFilter) async {
    final requestId = ++_requestId;
    _statusFilter = statusFilter;
    resetPagination();
    emit(const ViewOrdersState.loading());
    final result = await _getOrders(cookId: currentCookId, statusFilter: statusFilter);
    if (requestId != _requestId) return;
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewOrdersState.loaded(orders: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) => emit(ViewOrdersState.error(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;
    final requestId = ++_requestId;
    isLoadingMore = true;
    emit(ViewOrdersState.loaded(orders: items, hasMore: hasMore, isLoadingMore: true));
    final result = await _getOrders(
      cookId: currentCookId,
      statusFilter: _statusFilter,
      cursor: cursor,
    );
    if (requestId != _requestId) return;
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewOrdersState.loaded(orders: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) {
        isLoadingMore = false;
        emit(ViewOrdersState.loaded(orders: items, hasMore: hasMore, isLoadingMore: false));
      },
    );
  }
}
