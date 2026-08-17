import 'package:core/core.dart';

/// Real Dio-backed data source for `PATCH /users/password` — confirmed
/// live. `confirm_password` reuses [newPassword] since the cubit already
/// guarantees the on-screen confirm field matches it before submitting.
class PasswordRemoteDataSource {
  PasswordRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _apiClient.patch('/users/password', data: {
      'old_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': newPassword,
    });
  }
}
