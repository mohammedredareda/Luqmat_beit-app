import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class ResetPassword {
  const ResetPassword(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({required String phone, required String newPassword}) {
    return _repository.resetPassword(phone: phone, newPassword: newPassword);
  }
}
