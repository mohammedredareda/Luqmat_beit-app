import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart' show OtpPurpose;
import 'auth_data_source.dart';

/// Stands in for `auth_remote_data_source.dart` until a backend exists.
/// Registered users live in an in-memory map for the session; OTP is
/// simulated by accepting the fixed test code below regardless of phone —
/// swapping in a real SMS-backed API later only touches this file.
class AuthMockDataSource implements AuthDataSource {
  static const testOtpCode = '1234';

  final Map<String, _MockAccount> _accounts = {};

  @override
  Future<void> registerCustomer({
    required String fullName,
    required String phone,
    required String password,
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (_accounts.containsKey(phone)) {
      throw const ConflictException('يوجد حساب مسجّل بهذا الرقم مسبقاً.');
    }
    _accounts[phone] = _MockAccount(fullName: fullName, phone: phone, password: password);
  }

  @override
  Future<UserEntity> login({required String phone, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final account = _accounts[phone];
    if (account == null || account.password != password) {
      throw const UnauthorizedException('رقم الهاتف أو كلمة المرور غير صحيحة.');
    }
    return UserEntity(
      id: phone,
      name: account.fullName,
      phone: phone,
      role: UserRole.customer,
    );
  }

  @override
  Future<void> requestOtp(String phone, {OtpPurpose purpose = OtpPurpose.registration}) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (code != testOtpCode) {
      throw const ValidationException('رمز التحقق غير صحيح.');
    }
  }

  @override
  Future<void> resetPassword({required String phone, required String newPassword}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final account = _accounts[phone];
    if (account == null) {
      throw const NotFoundException('لا يوجد حساب مرتبط بهذا الرقم.');
    }
    _accounts[phone] = _MockAccount(
      fullName: account.fullName,
      phone: phone,
      password: newPassword,
    );
  }
}

class _MockAccount {
  const _MockAccount({required this.fullName, required this.phone, required this.password});

  final String fullName;
  final String phone;
  final String password;
}
