import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart' show OtpPurpose;
import '../../../domain/usecases/request_otp.dart';
import '../../../domain/usecases/verify_otp.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this._requestOtp,
    this._verifyOtp, {
    required this.phone,
    this.purpose = OtpPurpose.registration,
  }) : super(OtpState.initial());

  final RequestOtp _requestOtp;
  final VerifyOtp _verifyOtp;
  final String phone;
  final OtpPurpose purpose;

  void codeChanged(String value) => emit(state.copyWith(code: value, errorMessage: null));

  Future<void> resend() async {
    emit(state.copyWith(isResending: true));
    await _requestOtp(phone, purpose: purpose);
    emit(state.copyWith(isResending: false));
  }

  Future<void> verify() async {
    if (state.code.length < 4) {
      emit(state.copyWith(errorMessage: 'الرجاء إدخال رمز التحقق كاملاً.'));
      return;
    }
    emit(state.copyWith(isVerifying: true, errorMessage: null));
    final result = await _verifyOtp(phone: phone, code: state.code, purpose: purpose);
    result.fold(
      (_) => emit(state.copyWith(isVerifying: false, verified: true)),
      (exception) => emit(state.copyWith(isVerifying: false, errorMessage: exception.message)),
    );
  }
}
