import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/change_phone_number_repository.dart';

@injectable
class RequestPhoneChange {
  RequestPhoneChange(this._repository);

  final ChangePhoneNumberRepository _repository;

  Future<Result<void>> call({required String cookId, required String newPhoneNumber}) =>
      _repository.requestPhoneChange(cookId: cookId, newPhoneNumber: newPhoneNumber);
}
