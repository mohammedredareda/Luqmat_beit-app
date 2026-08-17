import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_by_id.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit(this._getOrderById) : super(const InvoiceState.initial());

  final GetOrderById _getOrderById;

  Future<void> loadOrder(String orderId) async {
    emit(const InvoiceState.loading());
    final result = await _getOrderById(orderId);
    if (isClosed) return;
    result.fold(
      (order) => emit(InvoiceState.loaded(order)),
      (exception) => emit(InvoiceState.failure(exception)),
    );
  }
}
