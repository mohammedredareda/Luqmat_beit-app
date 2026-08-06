import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_history_state.freezed.dart';

/// Single fetch-and-display flow (CU-20/21), no branching outcomes — hence
/// a Cubit with a plain loading/loaded/error state, not a Bloc.
@freezed
sealed class OrderHistoryState with _$OrderHistoryState {
  const factory OrderHistoryState.initial() = OrderHistoryInitial;
  const factory OrderHistoryState.loading() = OrderHistoryLoading;
  const factory OrderHistoryState.loaded(List<OrderEntity> orders) = OrderHistoryLoaded;
  const factory OrderHistoryState.failure(AppException exception) = OrderHistoryFailure;
}
