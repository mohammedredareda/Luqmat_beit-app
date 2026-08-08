import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_phone_number_state.freezed.dart';

/// Three UI-distinct outcomes (phone-input, OTP-entry, success) that the
/// UI must render as entirely different bodies — a Bloc, not a Cubit, per
/// the architecture's decision rule (unlike `ChangePasswordCubit`, whose
/// exception flows collapse into the same inline-error rendering).
@freezed
class ChangePhoneNumberState with _$ChangePhoneNumberState {
  const factory ChangePhoneNumberState.enteringPhone({
    @Default('') String phoneNumber,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = ChangePhoneNumberEnteringPhone;

  const factory ChangePhoneNumberState.enteringOtp({
    required String phoneNumber,
    @Default('') String otp,
    @Default(false) bool isVerifying,
    @Default(false) bool isResending,
    String? errorMessage,
  }) = ChangePhoneNumberEnteringOtp;

  const factory ChangePhoneNumberState.success(String phoneNumber) = ChangePhoneNumberSuccess;
}
