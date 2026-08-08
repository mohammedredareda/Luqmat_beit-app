import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_confirmation_state.freezed.dart';

/// Single fetch-and-display flow (CU-18: show the just-placed order) — a
/// Cubit with a plain loading/loaded/error state, not a Bloc.
@freezed
sealed class OrderConfirmationState with _$OrderConfirmationState {
  const factory OrderConfirmationState.initial() = OrderConfirmationInitial;
  const factory OrderConfirmationState.loading() = OrderConfirmationLoading;
  const factory OrderConfirmationState.loaded(OrderEntity order) =
      OrderConfirmationLoaded;
  const factory OrderConfirmationState.failure(AppException exception) =
      OrderConfirmationFailure;
}
