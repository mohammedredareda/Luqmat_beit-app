import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart';

/// `login`/`requestOtp`/`verifyOtp`/`resetPassword` delegate to core's
/// shared `AuthSessionRepository` (identical API calls for both roles).
/// `register` stays local since the request body shape differs by role.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required ApiClient apiClient, required AuthSessionRepository session})
      : _apiClient = apiClient,
        _session = session;

  final ApiClient _apiClient;
  final AuthSessionRepository _session;

  @override
  Future<Result<void>> register({
    required UserRole role,
    required String name,
    required String phone,
    required String password,
    required String address,
    String? description,
    String? availabilityDuration,
    double? latitude,
    double? longitude,
  }) {
    return guard<void>(() async {
      await _apiClient.post('/auth/register', data: {
        'name': name,
        'phone_number': phone,
        'address': address,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'password': password,
        'confirm_password': password,
        'role': role == UserRole.cook ? 'COOK' : 'CUSTOMER',
        if (role == UserRole.cook) ...{
          'avalability_duration': availabilityDuration,
          'cook_description': description,
        },
      });
    });
  }

  @override
  Future<Result<UserEntity>> login({required String phone, required String password}) =>
      _session.login(phone: phone, password: password);

  @override
  Future<Result<void>> requestOtp(String phone, {OtpPurpose purpose = OtpPurpose.registration}) =>
      _session.requestOtp(phone, purpose: purpose);

  @override
  Future<Result<void>> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) =>
      _session.verifyOtp(phone: phone, code: code, purpose: purpose);

  @override
  Future<Result<void>> resetPassword({required String phone, required String newPassword}) =>
      _session.resetPassword(phone: phone, newPassword: newPassword);
}
