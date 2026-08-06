import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';
import '../datasources/auth_mock_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({AuthDataSource? dataSource})
      : _dataSource = dataSource ?? AuthMockDataSource();

  final AuthDataSource _dataSource;

  @override
  Future<Result<void>> registerCustomer({
    required String fullName,
    required String phone,
    required String password,
    required String address,
    double? latitude,
    double? longitude,
  }) {
    return guard(() => _dataSource.registerCustomer(
          fullName: fullName,
          phone: phone,
          password: password,
          address: address,
          latitude: latitude,
          longitude: longitude,
        ));
  }

  @override
  Future<Result<UserEntity>> login({required String phone, required String password}) {
    return guard(() => _dataSource.login(phone: phone, password: password));
  }

  @override
  Future<Result<void>> requestOtp(String phone, {OtpPurpose purpose = OtpPurpose.registration}) {
    return guard(() => _dataSource.requestOtp(phone, purpose: purpose));
  }

  @override
  Future<Result<void>> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) {
    return guard(() => _dataSource.verifyOtp(phone: phone, code: code, purpose: purpose));
  }

  @override
  Future<Result<void>> resetPassword({required String phone, required String newPassword}) {
    return guard(() => _dataSource.resetPassword(phone: phone, newPassword: newPassword));
  }
}
