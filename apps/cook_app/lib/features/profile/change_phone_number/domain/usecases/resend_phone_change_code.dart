import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/change_phone_number_repository.dart';

@injectable
class ResendPhoneChangeCode {
  ResendPhoneChangeCode(this._repository);

  final ChangePhoneNumberRepository _repository;

  Future<Result<void>> call({required String cookId}) => _repository.resendCode(cookId: cookId);
}
