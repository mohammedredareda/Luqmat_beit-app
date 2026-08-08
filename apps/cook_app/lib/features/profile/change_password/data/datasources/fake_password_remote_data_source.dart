import 'package:core/core.dart';

import 'package:cook_app/shared/current_cook_id.dart';

/// In-memory stand-in for the real password-change endpoint — no backend
/// exists yet. Seeded so the dev flow has a known current password to
/// test against, mirroring `FakeCookProfileRemoteDataSource`'s role.
class FakePasswordRemoteDataSource {
  final Map<String, String> _passwordsByCookId = {currentCookId: 'Password123!'};

  Future<void> changePassword({
    required String cookId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final stored = _passwordsByCookId[cookId];
    if (stored != currentPassword) {
      throw const ValidationException(
        'The current password is incorrect.',
        fieldErrors: {
          'currentPassword': ['incorrect'],
        },
      );
    }
    _passwordsByCookId[cookId] = newPassword;
  }
}
