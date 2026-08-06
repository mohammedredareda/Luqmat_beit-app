import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_state.freezed.dart';

/// Single fetch-and-display flow (CU-19: show a past order's line items) —
/// a Cubit with a plain loading/loaded/error state, not a Bloc.
@freezed
sealed class InvoiceState with _$InvoiceState {
  const factory InvoiceState.initial() = InvoiceInitial;
  const factory InvoiceState.loading() = InvoiceLoading;
  const factory InvoiceState.loaded(OrderEntity order) = InvoiceLoaded;
  const factory InvoiceState.failure(AppException exception) = InvoiceFailure;
}
