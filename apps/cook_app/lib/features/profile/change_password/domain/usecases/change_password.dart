import 'package:core/core.dart';

import '../repositories/change_password_repository.dart';

class ChangePassword {
  ChangePassword(this._repository);

  final ChangePasswordRepository _repository;

  Future<Result<void>> call({
    required String cookId,
    required String currentPassword,
    required String newPassword,
  }) =>
      _repository.changePassword(
        cookId: cookId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
}
