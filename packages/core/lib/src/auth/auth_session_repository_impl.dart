import '../entities/user_entity.dart';
import '../network/api_client.dart';
import '../network/jwt_payload.dart';
import '../network/result.dart';
import '../storage/secure_token_storage.dart';
import '../storage/user_profile_cache.dart';
import 'auth_session_repository.dart';
import 'otp_purpose.dart';

/// Real implementation, backed by `AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json`
/// (Auth folder) and confirmed against the live deployment. Shared by both
/// apps — login/OTP/reset-password are byte-identical regardless of
/// `UserEntity.role`; only registration (each app's own repository) differs.
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
class AuthSessionRepositoryImpl implements AuthSessionRepository {
  AuthSessionRepositoryImpl(this._apiClient, this._tokenStorage, this._profileCache);

  final ApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;
  final UserProfileCache _profileCache;

  String? _pendingResetToken;

  @override
  Future<Result<UserEntity>> login({
    required String phone,
    required String password,
  }) {
    return guard(() async {
      final response = await _apiClient.post('/auth/login', data: {
        'phone_number': phone,
        'password': password,
      });
      final token = (response as Map)['token'] as String;
      await _tokenStorage.saveTokens(accessToken: token);

      final claims = decodeJwtPayload(token);
      final name = (claims['name'] ?? claims['full_name'] ?? '').toString();
      // The backend has no "get my profile" endpoint — this is the only
      // place a returning user's phone (and, if the JWT ever carries one, a
      // name) gets persisted for the profile screen to read back. See
      // [UserProfileCache]'s doc comment for the gap this doesn't close.
      await _profileCache.save(phone: phone, name: name.isEmpty ? null : name);

      return UserEntity(
        id: (claims['sub'] ?? claims['id'] ?? phone).toString(),
        name: name,
        phone: phone,
        role: (claims['role'] ?? '').toString().toUpperCase() == 'COOK'
            ? UserRole.cook
            : UserRole.customer,
      );
    });
  }

  @override
  Future<Result<void>> requestOtp(
    String phone, {
    OtpPurpose purpose = OtpPurpose.registration,
  }) {
    return guard(() async {
      final path = purpose == OtpPurpose.registration
          ? '/auth/verify/resend'
          : '/auth/forget-password';
      await _apiClient.post(path, data: {'phone_number': phone});
    });
  }

  @override
  Future<Result<void>> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) {
    return guard(() async {
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
    });
  }

  @override
  Future<Result<void>> resetPassword({
    required String phone,
    required String newPassword,
  }) {
    return guard(() async {
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
    });
  }
}
