import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_history.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit(this._getOrderHistory) : super(const OrderHistoryState.initial());

  final GetOrderHistory _getOrderHistory;

  Future<void> loadOrderHistory() async {
    emit(const OrderHistoryState.loading());
    final result = await _getOrderHistory();
    result.fold(
      (orders) => emit(OrderHistoryState.loaded(orders)),
      (exception) => emit(OrderHistoryState.failure(exception)),
    );
  }
}
