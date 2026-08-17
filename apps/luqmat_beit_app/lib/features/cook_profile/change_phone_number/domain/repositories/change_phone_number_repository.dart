import 'package:core/core.dart';

abstract class ChangePhoneNumberRepository {
  Future<Result<void>> requestPhoneChange({required String cookId, required String newPhoneNumber});

  /// The real API has no dedicated resend endpoint — this just re-sends
  /// the request, so [newPhoneNumber] is needed again.
  Future<Result<void>> resendCode({required String cookId, required String newPhoneNumber});

  /// Verifies [code] against [newPhoneNumber] and, on success, returns the
  /// now-confirmed phone number (there's no server-tracked pending state
  /// the confirm call can omit it and rely on).
  Future<Result<String>> verifyPhoneChange({
    required String cookId,
    required String newPhoneNumber,
    required String code,
  });
}
