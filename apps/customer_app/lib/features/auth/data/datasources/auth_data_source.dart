import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart' show OtpPurpose;

/// Shared shape for [AuthMockDataSource] and `AuthRemoteDataSource` so
/// `AuthRepositoryImpl` can hold either without caring which.
abstract class AuthDataSource {
  Future<void> registerCustomer({
    required String fullName,
    required String phone,
    required String password,
    required String address,
    double? latitude,
    double? longitude,
  });

  Future<UserEntity> login({required String phone, required String password});

  Future<void> requestOtp(String phone, {OtpPurpose purpose = OtpPurpose.registration});

  Future<void> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  });

  Future<void> resetPassword({required String phone, required String newPassword});
}
