import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.freezed.dart';

@freezed
abstract class OtpState with _$OtpState {
  const factory OtpState({
    @Default('') String code,
    @Default(false) bool isVerifying,
    @Default(false) bool isResending,
    @Default(false) bool verified,
    String? errorMessage,
  }) = _OtpState;

  factory OtpState.initial() => const OtpState();
}
