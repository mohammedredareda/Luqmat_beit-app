import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../domain/phone_number_validator.dart';
import '../../domain/usecases/request_phone_change.dart';
import '../../domain/usecases/resend_phone_change_code.dart';
import '../../domain/usecases/verify_phone_change_otp.dart';
import 'change_phone_number_event.dart';
import 'change_phone_number_state.dart';

class ChangePhoneNumberBloc extends Bloc<ChangePhoneNumberEvent, ChangePhoneNumberState> {
  ChangePhoneNumberBloc(
    this._requestPhoneChange,
    this._verifyPhoneChangeOtp,
    this._resendPhoneChangeCode,
  ) : super(const ChangePhoneNumberState.enteringPhone()) {
    on<ChangePhoneNumberEvent>((event, emit) => event.when(
          phoneNumberChanged: (value) => _onPhoneNumberChanged(value, emit),
          sendCodeSubmitted: () => _onSendCodeSubmitted(emit),
          otpChanged: (value) => _onOtpChanged(value, emit),
          resendPressed: () => _onResendPressed(emit),
          verifySubmitted: () => _onVerifySubmitted(emit),
          backToPhoneInputPressed: () => _onBackToPhoneInputPressed(emit),
        ));
  }

  final RequestPhoneChange _requestPhoneChange;
  final VerifyPhoneChangeOtp _verifyPhoneChangeOtp;
  final ResendPhoneChangeCode _resendPhoneChangeCode;

  void _onPhoneNumberChanged(String value, Emitter<ChangePhoneNumberState> emit) {
    final current = state;
    if (current is ChangePhoneNumberEnteringPhone) {
      emit(current.copyWith(phoneNumber: value, errorMessage: null));
    }
  }

  Future<void> _onSendCodeSubmitted(Emitter<ChangePhoneNumberState> emit) async {
    final current = state;
    if (current is! ChangePhoneNumberEnteringPhone) return;

    if (!isValidLocalPhoneNumber(current.phoneNumber)) {
      emit(current.copyWith(errorMessage: 'invalidPhoneNumber'));
      return;
    }

    emit(current.copyWith(isSubmitting: true, errorMessage: null));
    final result = await _requestPhoneChange(
      cookId: currentCookId,
      newPhoneNumber: formatLocalPhoneNumber(current.phoneNumber),
    );
    result.fold(
      (_) => emit(ChangePhoneNumberState.enteringOtp(phoneNumber: current.phoneNumber)),
      (exception) => emit(current.copyWith(isSubmitting: false, errorMessage: exception.message)),
    );
  }

  void _onOtpChanged(String value, Emitter<ChangePhoneNumberState> emit) {
    final current = state;
    if (current is ChangePhoneNumberEnteringOtp) {
      emit(current.copyWith(otp: value, errorMessage: null));
    }
  }

  Future<void> _onResendPressed(Emitter<ChangePhoneNumberState> emit) async {
    final current = state;
    if (current is! ChangePhoneNumberEnteringOtp) return;

    emit(current.copyWith(isResending: true, errorMessage: null));
    final result = await _resendPhoneChangeCode(cookId: currentCookId);
    result.fold(
      (_) => emit(current.copyWith(isResending: false)),
      (exception) => emit(current.copyWith(isResending: false, errorMessage: exception.message)),
    );
  }

  Future<void> _onVerifySubmitted(Emitter<ChangePhoneNumberState> emit) async {
    final current = state;
    if (current is! ChangePhoneNumberEnteringOtp) return;

    emit(current.copyWith(isVerifying: true, errorMessage: null));
    final result = await _verifyPhoneChangeOtp(cookId: currentCookId, code: current.otp);
    result.fold(
      (profile) => emit(ChangePhoneNumberState.success(profile.phoneNumber)),
      (exception) => emit(current.copyWith(
        isVerifying: false,
        errorMessage: exception is ValidationException && exception.fieldErrors.containsKey('otp')
            ? 'incorrect'
            : exception.message,
      )),
    );
  }

  void _onBackToPhoneInputPressed(Emitter<ChangePhoneNumberState> emit) {
    final current = state;
    if (current is ChangePhoneNumberEnteringOtp) {
      emit(ChangePhoneNumberState.enteringPhone(phoneNumber: current.phoneNumber));
    }
  }
}
