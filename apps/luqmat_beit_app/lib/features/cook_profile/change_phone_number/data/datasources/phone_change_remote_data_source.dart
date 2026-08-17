import 'package:core/core.dart';

/// Real Dio-backed data source for phone-number change — confirmed live:
/// `POST /users/phone/request` (sends an OTP) and `POST
/// /users/phone/confirm` (verifies it and applies the change). No
/// dedicated resend endpoint exists — resend just re-calls `request`.
class PhoneChangeRemoteDataSource {
  PhoneChangeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> requestPhoneChange(String newPhoneNumber) async {
    await _apiClient.post('/users/phone/request', data: {'new_phone_number': newPhoneNumber});
  }

  /// The confirmed response is `{message, user: {...}}` — a thin `user`
  /// object that doesn't match `CookProfileModel`'s rich shape, and
  /// nothing downstream needs more than the confirmed phone number, so
  /// this returns just that rather than fabricating a full profile.
  Future<String> verifyPhoneChange({
    required String newPhoneNumber,
    required String code,
  }) async {
    final response = await _apiClient.post('/users/phone/confirm', data: {
      'new_phone_number': newPhoneNumber,
      'code': code,
    }) as Map;
    final user = response['user'] as Map?;
    final phone = user?['phone'] as String?;
    if (phone == null) {
      throw const UnknownException('حدث خطأ ما. حاول مرة أخرى.');
    }
    return phone;
  }
}
