import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart' show OtpPurpose;
import 'auth_data_source.dart';

/// Real implementation, backed by `AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`
/// (Auth folder). Mirrors [AuthMockDataSource]'s method signatures exactly —
/// see `auth_data_source.dart` for the shared contract.
///
/// Two backend quirks this file works around:
/// - `POST /auth/login` returns only `{message, token}`, no user object, so
///   [UserEntity] is populated by best-effort decoding the JWT payload.
/// - `POST /auth/reset-password` (the Postman collection has this saved as
///   PUT, which the real server rejects with "Cannot PUT
///   /auth/reset-password" — confirmed against the live deployment) is
///   authenticated with a short-lived token returned by `POST /auth/verify`
///   (purpose: password reset) — not the normal session token — so it's
///   held in memory here between `verifyOtp` and `resetPassword` rather
///   than written to [SecureTokenStorage].
class AuthRemoteDataSource implements AuthDataSource {
  AuthRemoteDataSource(this._apiClient, this._tokenStorage);

  final ApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;

  String? _pendingResetToken;

  @override
  Future<void> registerCustomer({
    required String fullName,
    required String phone,
    required String password,
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    await _apiClient.post('/auth/register', data: {
      'name': fullName,
      'phone_number': phone,
      'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'password': password,
      'confirm_password': password,
      'role': 'CUSTOMER',
    });
  }

  @override
  Future<UserEntity> login({required String phone, required String password}) async {
    final response = await _apiClient.post('/auth/login', data: {
      'phone_number': phone,
      'password': password,
    });
    final token = (response as Map)['token'] as String;
    await _tokenStorage.saveTokens(accessToken: token);

    final claims = decodeJwtPayload(token);
    return UserEntity(
      id: (claims['sub'] ?? claims['id'] ?? phone).toString(),
      name: (claims['name'] ?? claims['full_name'] ?? '').toString(),
      phone: phone,
      role: UserRole.customer,
    );
  }

  @override
  Future<void> requestOtp(String phone, {OtpPurpose purpose = OtpPurpose.registration}) async {
    final path = purpose == OtpPurpose.registration
        ? '/auth/verify/resend'
        : '/auth/forget-password';
    await _apiClient.post(path, data: {'phone_number': phone});
  }

  @override
  Future<void> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) async {
    final response = await _apiClient.post('/auth/verify', data: {
      'phone_number': phone,
      'code': code,
    });
    final token = (response as Map)['access_token'] as String?;
    if (token == null) return;
    if (purpose == OtpPurpose.registration) {
      await _tokenStorage.saveTokens(accessToken: token);
    } else {
      _pendingResetToken = token;
    }
  }

  @override
  Future<void> resetPassword({required String phone, required String newPassword}) async {
    final resetToken = _pendingResetToken;
    await _apiClient.post(
      '/auth/reset-password',
      data: {
        'new_password': newPassword,
        'confirm_new_password': newPassword,
      },
      headers: resetToken != null ? {'Authorization': 'Bearer $resetToken'} : null,
    );
    _pendingResetToken = null;
  }
}
