import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_history.dart';
import '../../domain/usecases/reorder_past_order.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit(this._getOrderHistory, this._reorderPastOrder)
      : super(const OrderHistoryState.initial());

  final GetOrderHistory _getOrderHistory;
  final ReorderPastOrder _reorderPastOrder;

  Future<void> loadOrderHistory() async {
    emit(const OrderHistoryState.loading());
    final result = await _getOrderHistory();
    if (isClosed) return;
    result.fold(
      (orders) => emit(OrderHistoryState.loaded(orders)),
      (exception) => emit(OrderHistoryState.failure(exception)),
    );
  }

  /// Doesn't touch [state] — the loaded list is unaffected by a reorder, so
  /// the result is reported straight back to the calling widget (same
  /// fire-and-report shape as `MealDetailsCubit.report`).
  Future<Result<void>> reorder(String orderId) => _reorderPastOrder(orderId);
}
