import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
sealed class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = ResetPasswordInitial;
  const factory ResetPasswordState.submitting() = ResetPasswordSubmitting;
  const factory ResetPasswordState.success() = ResetPasswordSuccess;
  const factory ResetPasswordState.failure(AppException exception) = ResetPasswordFailure;
}
