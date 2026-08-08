import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.submitting() = LoginSubmitting;
  const factory LoginState.success(UserEntity user) = LoginSuccess;
  const factory LoginState.failure(AppException exception) = LoginFailure;
}
