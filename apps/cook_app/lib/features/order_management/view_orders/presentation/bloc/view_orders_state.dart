import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_orders_state.freezed.dart';

@freezed
class ViewOrdersState with _$ViewOrdersState {
  const factory ViewOrdersState.initial() = ViewOrdersInitial;
  const factory ViewOrdersState.loading() = ViewOrdersLoading;
  const factory ViewOrdersState.loaded({
    required List<OrderEntity> orders,
    required bool hasMore,
    required bool isLoadingMore,
  }) = ViewOrdersLoaded;
  const factory ViewOrdersState.error(AppException exception) = ViewOrdersError;
}
