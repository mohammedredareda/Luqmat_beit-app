import 'package:core/core.dart';

import '../repositories/change_phone_number_repository.dart';

class VerifyPhoneChangeOtp {
  VerifyPhoneChangeOtp(this._repository);

  final ChangePhoneNumberRepository _repository;

  /// Resolves to the now-confirmed phone number.
  Future<Result<String>> call({
    required String cookId,
    required String newPhoneNumber,
    required String code,
  }) =>
      _repository.verifyPhoneChange(cookId: cookId, newPhoneNumber: newPhoneNumber, code: code);
}
