import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_event.freezed.dart';

@freezed
class OrderDetailsEvent with _$OrderDetailsEvent {
  const factory OrderDetailsEvent.loadRequested(String orderId) = _LoadRequested;
  const factory OrderDetailsEvent.acceptPressed() = _AcceptPressed;
  const factory OrderDetailsEvent.rejectPressed([String? reason]) = _RejectPressed;
  const factory OrderDetailsEvent.completePressed() = _CompletePressed;
}
