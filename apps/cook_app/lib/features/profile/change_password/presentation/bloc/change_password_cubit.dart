import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/password_validator.dart';
import '../../domain/usecases/change_password.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._changePassword) : super(const ChangePasswordState.idle());

  final ChangePassword _changePassword;

  Future<void> submit({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final errors = <String, List<String>>{};
    if (currentPassword.isEmpty) errors['currentPassword'] = ['required'];

    final newPasswordErrors = validateNewPassword(newPassword);
    if (newPasswordErrors.isNotEmpty) errors['newPassword'] = newPasswordErrors;

    if (newPasswordErrors.isEmpty && confirmPassword != newPassword) {
      errors['confirmPassword'] = ['mismatch'];
    }

    if (errors.isNotEmpty) {
      emit(ChangePasswordState.fieldErrors(errors));
      return;
    }

    emit(const ChangePasswordState.submitting());
    final result = await _changePassword(
      cookId: currentCookId,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (_) => emit(const ChangePasswordState.success()),
      (exception) => emit(
        exception is ValidationException && exception.fieldErrors.isNotEmpty
            ? ChangePasswordState.fieldErrors(exception.fieldErrors)
            : ChangePasswordState.failure(exception),
      ),
    );
  }
}
