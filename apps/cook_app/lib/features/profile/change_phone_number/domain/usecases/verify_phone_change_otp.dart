import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';
import '../repositories/change_phone_number_repository.dart';

class VerifyPhoneChangeOtp {
  VerifyPhoneChangeOtp(this._repository);

  final ChangePhoneNumberRepository _repository;

  Future<Result<CookProfileDetails>> call({required String cookId, required String code}) =>
      _repository.verifyPhoneChange(cookId: cookId, code: code);
}
