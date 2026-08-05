import 'package:core/core.dart';

abstract class ChangePasswordRepository {
  /// Verifies [currentPassword] and, if correct, updates the cook's
  /// password to [newPassword]. Field-level failures (wrong current
  /// password) surface as a [ValidationException] with a `currentPassword`
  /// entry in `fieldErrors`.
  Future<Result<void>> changePassword({
    required String cookId,
    required String currentPassword,
    required String newPassword,
  });
}
