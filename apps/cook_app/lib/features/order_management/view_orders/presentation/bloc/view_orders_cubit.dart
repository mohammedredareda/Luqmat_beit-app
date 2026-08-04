import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_orders.dart';
import 'view_orders_state.dart';

/// CK-16 View My Orders — a single fetch-and-display flow per filter
/// (loading/loaded/error, no branching outcomes), same Cubit-over-Bloc
/// reasoning as `ViewMenuCubit`.
@injectable
class ViewOrdersCubit extends Cubit<ViewOrdersState> {
  ViewOrdersCubit(this._getOrders) : super(const ViewOrdersState.initial());

  final GetOrders _getOrders;

  /// Guards against a slower earlier request (e.g. a fast double tab
  /// switch) overwriting the result of a later one.
  int _requestId = 0;

  Future<void> loadOrders(OrderStatus? statusFilter) async {
    final requestId = ++_requestId;
    emit(const ViewOrdersState.loading());
    final result = await _getOrders(cookId: currentCookId, statusFilter: statusFilter);
    if (requestId != _requestId) return;
    result.fold(
      (orders) => emit(ViewOrdersState.loaded(orders)),
      (exception) => emit(ViewOrdersState.error(exception)),
    );
  }
}
