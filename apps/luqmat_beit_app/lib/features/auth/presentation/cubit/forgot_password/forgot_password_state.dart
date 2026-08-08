import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
sealed class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;
  const factory ForgotPasswordState.submitting() = ForgotPasswordSubmitting;
  const factory ForgotPasswordState.sent(String phone) = ForgotPasswordSent;
  const factory ForgotPasswordState.failure(AppException exception) = ForgotPasswordFailure;
}
