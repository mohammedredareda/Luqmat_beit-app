import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_action_status.freezed.dart';

/// The Accept/Reject/Complete submit outcome — nested inside
/// [OrderDetailsState.loaded] so the loaded order stays on screen through
/// every outcome, mirroring [MealSubmitStatus]'s role in `CreateMealState`.
@freezed
class OrderActionStatus with _$OrderActionStatus {
  const factory OrderActionStatus.idle() = OrderActionStatusIdle;
  const factory OrderActionStatus.submitting() = OrderActionStatusSubmitting;
  const factory OrderActionStatus.acceptSucceeded() = OrderActionStatusAcceptSucceeded;
  const factory OrderActionStatus.rejectSucceeded() = OrderActionStatusRejectSucceeded;
  const factory OrderActionStatus.completeSucceeded() = OrderActionStatusCompleteSucceeded;

  /// Defense-in-depth — the reject dialog already disables submission while
  /// the reason field is empty, this covers any other call path.
  const factory OrderActionStatus.rejectionReasonRequired() =
      OrderActionStatusRejectionReasonRequired;

  /// CK-25's race: the pending timeout expired right as Accept was pressed.
  /// The server (fake datasource) has already flipped the order to
  /// `cancelled` by the time this is emitted.
  const factory OrderActionStatus.expired() = OrderActionStatusExpired;

  const factory OrderActionStatus.failure(AppException exception) = OrderActionStatusFailure;
}
