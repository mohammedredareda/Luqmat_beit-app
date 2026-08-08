import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/confirm_delivery_receipt.dart';
import '../../domain/usecases/get_delivered_order.dart';
import '../../domain/usecases/report_delivery_issue.dart';
import 'delivery_acceptance_event.dart';
import 'delivery_acceptance_state.dart';

class DeliveryAcceptanceBloc
    extends Bloc<DeliveryAcceptanceEvent, DeliveryAcceptanceState> {
  DeliveryAcceptanceBloc(
    this._getDeliveredOrder,
    this._confirmDeliveryReceipt,
    this._reportDeliveryIssue,
  ) : super(const DeliveryAcceptanceState.initial()) {
    on<DeliveryAcceptanceStarted>(_onStarted);
    on<ConfirmReceiptRequested>(_onConfirmReceiptRequested);
    on<ReportIssueToggled>(_onReportIssueToggled);
    on<ReasonChanged>(_onReasonChanged);
    on<ReportIssueSubmitted>(_onReportIssueSubmitted);
  }

  final GetDeliveredOrder _getDeliveredOrder;
  final ConfirmDeliveryReceipt _confirmDeliveryReceipt;
  final ReportDeliveryIssue _reportDeliveryIssue;

  String _orderId = '';

  Future<void> _onStarted(
    DeliveryAcceptanceStarted event,
    Emitter<DeliveryAcceptanceState> emit,
  ) async {
    _orderId = event.orderId;
    emit(const DeliveryAcceptanceState.loading());
    final result = await _getDeliveredOrder(event.orderId);
    result.fold(
      (order) => emit(DeliveryAcceptanceState.loaded(order)),
      (exception) => emit(DeliveryAcceptanceState.failure(exception)),
    );
  }

  Future<void> _onConfirmReceiptRequested(
    ConfirmReceiptRequested event,
    Emitter<DeliveryAcceptanceState> emit,
  ) async {
    final current = state;
    if (current is! DeliveryAcceptanceLoaded) return;

    emit(current.copyWith(isProcessing: true));
    final result = await _confirmDeliveryReceipt(_orderId);
    result.fold(
      (_) => emit(DeliveryAcceptanceState.confirmed(current.order)),
      (exception) => emit(DeliveryAcceptanceState.failure(exception)),
    );
  }

  void _onReportIssueToggled(
    ReportIssueToggled event,
    Emitter<DeliveryAcceptanceState> emit,
  ) {
    final current = state;
    if (current is! DeliveryAcceptanceLoaded) return;

    emit(
      current.copyWith(
        isReportingIssue: !current.isReportingIssue,
        reasonError: null,
      ),
    );
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<DeliveryAcceptanceState> emit,
  ) {
    final current = state;
    if (current is! DeliveryAcceptanceLoaded) return;

    emit(current.copyWith(reason: event.reason, reasonError: null));
  }

  Future<void> _onReportIssueSubmitted(
    ReportIssueSubmitted event,
    Emitter<DeliveryAcceptanceState> emit,
  ) async {
    final current = state;
    if (current is! DeliveryAcceptanceLoaded) return;

    final validationError =
        NoteLengthValidator.rejectionReasonError(current.reason);
    if (validationError != null) {
      emit(current.copyWith(reasonError: validationError));
      return;
    }

    emit(current.copyWith(isProcessing: true));
    final result = await _reportDeliveryIssue(_orderId, current.reason);
    result.fold(
      (_) => emit(DeliveryAcceptanceState.reported(current.order)),
      (exception) => emit(DeliveryAcceptanceState.failure(exception)),
    );
  }
}
