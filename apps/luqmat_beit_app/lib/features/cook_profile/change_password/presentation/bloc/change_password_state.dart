import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

/// A single Main Success Scenario with loading/error/loaded-equivalent
/// states — a Cubit per the architecture's own decision rule. CK-27's two
/// exception flows (wrong current password, weak new password) both
/// render the same way here: an inline field error, not a UI-distinct
/// outcome.
@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.idle() = ChangePasswordIdle;
  const factory ChangePasswordState.submitting() = ChangePasswordSubmitting;
  const factory ChangePasswordState.fieldErrors(Map<String, List<String>> fieldErrors) =
      ChangePasswordFieldErrors;
  const factory ChangePasswordState.success() = ChangePasswordSuccess;
  const factory ChangePasswordState.failure(AppException exception) = ChangePasswordFailure;
}
