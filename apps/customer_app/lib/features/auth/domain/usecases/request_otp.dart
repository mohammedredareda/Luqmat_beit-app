import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class RequestOtp {
  const RequestOtp(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(
    String phone, {
    OtpPurpose purpose = OtpPurpose.registration,
  }) {
    return _repository.requestOtp(phone, purpose: purpose);
  }
}
