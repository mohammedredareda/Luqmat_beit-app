import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_phone_number_event.freezed.dart';

@freezed
class ChangePhoneNumberEvent with _$ChangePhoneNumberEvent {
  const factory ChangePhoneNumberEvent.phoneNumberChanged(String value) = _PhoneNumberChanged;
  const factory ChangePhoneNumberEvent.sendCodeSubmitted() = _SendCodeSubmitted;
  const factory ChangePhoneNumberEvent.otpChanged(String value) = _OtpChanged;
  const factory ChangePhoneNumberEvent.resendPressed() = _ResendPressed;
  const factory ChangePhoneNumberEvent.verifySubmitted() = _VerifySubmitted;
  const factory ChangePhoneNumberEvent.backToPhoneInputPressed() = _BackToPhoneInputPressed;
}
