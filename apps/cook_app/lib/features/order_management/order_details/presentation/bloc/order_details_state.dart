import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_action_status.dart';

part 'order_details_state.freezed.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.initial() = OrderDetailsInitial;
  const factory OrderDetailsState.loading() = OrderDetailsLoading;
  const factory OrderDetailsState.loadError(AppException exception) = OrderDetailsLoadError;
  const factory OrderDetailsState.loaded({
    required OrderEntity order,
    @Default(OrderActionStatus.idle()) OrderActionStatus actionStatus,
  }) = OrderDetailsLoaded;
}
