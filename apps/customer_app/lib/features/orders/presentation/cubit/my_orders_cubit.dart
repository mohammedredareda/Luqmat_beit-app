import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_in_progress_orders.dart';
import 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this._getInProgressOrders)
      : super(const MyOrdersState.initial());

  final GetInProgressOrders _getInProgressOrders;

  Future<void> loadOrders() async {
    emit(const MyOrdersState.loading());
    final result = await _getInProgressOrders();
    result.fold(
      (orders) => emit(MyOrdersState.loaded(orders)),
      (exception) => emit(MyOrdersState.failure(exception)),
    );
  }
}
