import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/reset_password.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPassword) : super(const ResetPasswordState.initial());

  final ResetPassword _resetPassword;

  Future<void> submit({required String phone, required String newPassword}) async {
    final passwordError = PasswordValidator.errorMessage(newPassword);
    if (passwordError != null) {
      emit(ResetPasswordState.failure(ValidationException(passwordError)));
      return;
    }
    emit(const ResetPasswordState.submitting());
    final result = await _resetPassword(phone: phone, newPassword: newPassword);
    result.fold(
      (_) => emit(const ResetPasswordState.success()),
      (exception) => emit(ResetPasswordState.failure(exception)),
    );
  }
}
