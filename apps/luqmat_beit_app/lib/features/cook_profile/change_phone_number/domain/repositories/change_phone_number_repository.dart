import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';

abstract class ChangePhoneNumberRepository {
  Future<Result<void>> requestPhoneChange({required String cookId, required String newPhoneNumber});

  Future<Result<void>> resendCode({required String cookId});

  /// Verifies [code] against the pending change and, on success, returns
  /// the profile with the new phone number already applied.
  Future<Result<CookProfileDetails>> verifyPhoneChange({required String cookId, required String code});
}
