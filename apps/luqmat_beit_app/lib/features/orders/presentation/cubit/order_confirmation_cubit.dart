import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_by_id.dart';
import 'order_confirmation_state.dart';

class OrderConfirmationCubit extends Cubit<OrderConfirmationState> {
  OrderConfirmationCubit(this._getOrderById)
      : super(const OrderConfirmationState.initial());

  final GetOrderById _getOrderById;

  Future<void> loadOrder(String orderId) async {
    emit(const OrderConfirmationState.loading());
    final result = await _getOrderById(orderId);
    if (isClosed) return;
    result.fold(
      (order) => emit(OrderConfirmationState.loaded(order)),
      (exception) => emit(OrderConfirmationState.failure(exception)),
    );
  }
}
