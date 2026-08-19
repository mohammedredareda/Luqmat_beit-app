import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_orders_state.freezed.dart';

/// Single fetch-and-display flow (CU-31: list in-progress orders) — a
/// Cubit with a plain loading/loaded/error state, not a Bloc.
@freezed
sealed class MyOrdersState with _$MyOrdersState {
  const factory MyOrdersState.initial() = MyOrdersInitial;
  const factory MyOrdersState.loading() = MyOrdersLoading;
  const factory MyOrdersState.loaded(List<OrderEntity> orders) = MyOrdersLoaded;
  const factory MyOrdersState.failure(AppException exception) = MyOrdersFailure;
}
