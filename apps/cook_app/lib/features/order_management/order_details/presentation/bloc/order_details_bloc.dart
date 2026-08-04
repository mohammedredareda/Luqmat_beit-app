import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/accept_order.dart';
import '../../domain/usecases/complete_order.dart';
import '../../domain/usecases/get_order.dart';
import '../../domain/usecases/reject_order.dart';
import 'order_action_status.dart';
import 'order_details_event.dart';
import 'order_details_state.dart';

/// CK-17 (read) + CK-18 (accept/reject) + CK-19 (complete) + CK-25's
/// client-side reaction to the accept-after-expiry race — one Bloc, since
/// all three stories share the identical read path and entity, and
/// CK-18/25 alone produce ≥3 UI-distinct outcomes (success, empty-reason-
/// blocked, expired-on-accept), which is the architecture doc's own
/// Bloc-over-Cubit criterion.
@injectable
class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc(
    this._getOrder,
    this._acceptOrder,
    this._rejectOrder,
    this._completeOrder,
  ) : super(const OrderDetailsState.initial()) {
    on<OrderDetailsEvent>((event, emit) => event.when(
          loadRequested: (orderId) => _load(orderId, emit),
          acceptPressed: () => _accept(emit),
          rejectPressed: (reason) => _reject(reason, emit),
          completePressed: () => _complete(emit),
        ));
  }

  final GetOrder _getOrder;
  final AcceptOrder _acceptOrder;
  final RejectOrder _rejectOrder;
  final CompleteOrder _completeOrder;

  /// The fake datasource's marker for CK-25's expired-pending race — see
  /// `FakeOrderRemoteDataSource.acceptOrder`.
  static const _expiredStatusCode = 410;

  Future<void> _load(String orderId, Emitter<OrderDetailsState> emit) async {
    emit(const OrderDetailsState.loading());
    final result = await _getOrder(orderId);
    result.fold(
      (order) => emit(OrderDetailsState.loaded(order: order)),
      (exception) => emit(OrderDetailsState.loadError(exception)),
    );
  }

  Future<void> _accept(Emitter<OrderDetailsState> emit) async {
    final loaded = _currentlyLoaded();
    if (loaded == null) return;

    emit(loaded.copyWith(actionStatus: const OrderActionStatus.submitting()));
    final result = await _acceptOrder(loaded.order.id);

    switch (result) {
      case Success(data: final order):
        emit(OrderDetailsState.loaded(
          order: order,
          actionStatus: const OrderActionStatus.acceptSucceeded(),
        ));
      case Failure(exception: final exception)
          when exception is ConflictException && exception.statusCode == _expiredStatusCode:
        // CK-25 race: pull the authoritative post-race order (now
        // `cancelled`) so the page can re-render its read-only view.
        final refreshed = await _getOrder(loaded.order.id);
        refreshed.fold(
          (order) => emit(OrderDetailsState.loaded(
            order: order,
            actionStatus: const OrderActionStatus.expired(),
          )),
          (exception) => emit(loaded.copyWith(actionStatus: OrderActionStatus.failure(exception))),
        );
      case Failure(exception: final exception):
        emit(loaded.copyWith(actionStatus: OrderActionStatus.failure(exception)));
    }
  }

  Future<void> _reject(String reason, Emitter<OrderDetailsState> emit) async {
    final loaded = _currentlyLoaded();
    if (loaded == null) return;

    if (reason.trim().isEmpty) {
      emit(loaded.copyWith(actionStatus: const OrderActionStatus.rejectionReasonRequired()));
      return;
    }

    emit(loaded.copyWith(actionStatus: const OrderActionStatus.submitting()));
    final result = await _rejectOrder(orderId: loaded.order.id, reason: reason.trim());
    result.fold(
      (order) => emit(OrderDetailsState.loaded(
        order: order,
        actionStatus: const OrderActionStatus.rejectSucceeded(),
      )),
      (exception) => emit(loaded.copyWith(actionStatus: OrderActionStatus.failure(exception))),
    );
  }

  Future<void> _complete(Emitter<OrderDetailsState> emit) async {
    final loaded = _currentlyLoaded();
    if (loaded == null) return;

    emit(loaded.copyWith(actionStatus: const OrderActionStatus.submitting()));
    final result = await _completeOrder(loaded.order.id);
    result.fold(
      (order) => emit(OrderDetailsState.loaded(
        order: order,
        actionStatus: const OrderActionStatus.completeSucceeded(),
      )),
      (exception) => emit(loaded.copyWith(actionStatus: OrderActionStatus.failure(exception))),
    );
  }

  OrderDetailsLoaded? _currentlyLoaded() {
    final current = state;
    return current is OrderDetailsLoaded ? current : null;
  }
}
