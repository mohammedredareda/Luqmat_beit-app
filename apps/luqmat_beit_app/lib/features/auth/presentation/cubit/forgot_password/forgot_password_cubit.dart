import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/request_otp.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._requestOtp) : super(const ForgotPasswordState.initial());

  final RequestOtp _requestOtp;

  Future<void> submit(String phone) async {
    final phoneError = PhoneValidator.errorMessage(phone.trim());
    if (phoneError != null) {
      emit(ForgotPasswordState.failure(ValidationException(phoneError)));
      return;
    }
    emit(const ForgotPasswordState.submitting());
    final result = await _requestOtp(phone.trim(), purpose: OtpPurpose.passwordReset);
    result.fold(
      (_) => emit(ForgotPasswordState.sent(phone.trim())),
      (exception) => emit(ForgotPasswordState.failure(exception)),
    );
  }
}
