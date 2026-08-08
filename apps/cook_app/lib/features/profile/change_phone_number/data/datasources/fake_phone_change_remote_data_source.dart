import 'package:core/core.dart';

import '../../../data/datasources/fake_cook_profile_remote_data_source.dart';
import '../../../data/models/cook_profile_model.dart';

/// In-memory stand-in for the real OTP-backed phone-change endpoint — no
/// backend exists yet. Uses a fixed dev OTP so the flow is testable
/// end-to-end without a real SMS/WhatsApp provider, and writes the new
/// number into the same shared fake profile store `edit_profile`/
/// `view_profile` read from.
class FakePhoneChangeRemoteDataSource {
  FakePhoneChangeRemoteDataSource(this._profileDataSource);

  static const _devOtp = '1234';

  final FakeCookProfileRemoteDataSource _profileDataSource;
  final Map<String, String> _pendingNumberByCookId = {};

  Future<void> requestPhoneChange(String cookId, String newPhoneNumber) async {
    _pendingNumberByCookId[cookId] = newPhoneNumber;
  }

  Future<void> resendCode(String cookId) async {
    // No-op in the fake — the dev OTP is fixed, nothing to regenerate.
  }

  Future<CookProfileModel> verifyPhoneChange(String cookId, String code) async {
    final pendingNumber = _pendingNumberByCookId[cookId];
    if (pendingNumber == null) {
      throw const NotFoundException('No pending phone number change.');
    }
    if (code != _devOtp) {
      throw const ValidationException(
        'The code is incorrect.',
        fieldErrors: {
          'otp': ['incorrect'],
        },
      );
    }

    final existing = await _profileDataSource.getProfile(cookId);
    final saved =
        await _profileDataSource.updateProfile(existing.copyWith(phoneNumber: pendingNumber));
    _pendingNumberByCookId.remove(cookId);
    return saved;
  }
}
