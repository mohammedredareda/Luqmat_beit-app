import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_acceptance_state.freezed.dart';

/// CU-22 has two UI-distinct outcomes — confirming receipt (a success
/// state) vs disputing it (reveals a reason form, then a *different*
/// success state) — plus a rejection-reason validation Exception Flow.
/// Per the architecture doc's §6 decision rule (>1 UI-distinct
/// Alternative/Exception Flow -> Bloc with explicit events), this is a
/// Bloc, not a Cubit.
@freezed
sealed class DeliveryAcceptanceState with _$DeliveryAcceptanceState {
  const factory DeliveryAcceptanceState.initial() = DeliveryAcceptanceInitial;

  const factory DeliveryAcceptanceState.loading() = DeliveryAcceptanceLoading;

  const factory DeliveryAcceptanceState.loaded(
    OrderEntity order, {
    @Default(false) bool isReportingIssue,
    @Default('') String reason,
    String? reasonError,
    @Default(false) bool isProcessing,
  }) = DeliveryAcceptanceLoaded;

  /// Customer confirmed receipt.
  const factory DeliveryAcceptanceState.confirmed(OrderEntity order) =
      DeliveryAcceptanceConfirmed;

  /// Customer disputed the delivery; reason was submitted successfully.
  const factory DeliveryAcceptanceState.reported(OrderEntity order) =
      DeliveryAcceptanceReported;

  const factory DeliveryAcceptanceState.failure(AppException exception) =
      DeliveryAcceptanceFailure;
}
