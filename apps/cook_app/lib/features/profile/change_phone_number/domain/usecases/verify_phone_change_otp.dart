import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/change_phone_number_repository.dart';

@injectable
class VerifyPhoneChangeOtp {
  VerifyPhoneChangeOtp(this._repository);

  final ChangePhoneNumberRepository _repository;

  Future<Result<CookProfileEntity>> call({required String cookId, required String code}) =>
      _repository.verifyPhoneChange(cookId: cookId, code: code);
}
