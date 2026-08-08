import 'package:core/core.dart';

import '../repositories/change_phone_number_repository.dart';

class ResendPhoneChangeCode {
  ResendPhoneChangeCode(this._repository);

  final ChangePhoneNumberRepository _repository;

  Future<Result<void>> call({required String cookId}) => _repository.resendCode(cookId: cookId);
}
