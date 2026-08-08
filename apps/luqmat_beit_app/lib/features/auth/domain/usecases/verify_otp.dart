import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class VerifyOtp {
  const VerifyOtp(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  }) {
    return _repository.verifyOtp(phone: phone, code: code, purpose: purpose);
  }
}
