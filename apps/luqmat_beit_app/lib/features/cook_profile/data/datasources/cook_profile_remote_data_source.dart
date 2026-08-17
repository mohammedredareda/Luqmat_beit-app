import 'package:core/core.dart';

import '../models/cook_profile_model.dart';

/// Real implementation backed by `/users/profile` — `GET` (confirmed live)
/// and `PATCH` (confirmed live, replaces the earlier `PUT /user/{id}`
/// guess, which 404'd "Cannot PUT" on the deployed server; that route
/// never existed). No `{id}` in either URL — the authenticated user is
/// resolved from the Bearer token server-side, so unlike the old PUT
/// guess this needs no JWT decoding here.
class CookProfileRemoteDataSource {
  CookProfileRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<CookProfileModel> getProfile(String cookId) async {
    final response = await _apiClient.get('/users/profile') as Map;
    final user = response['user'] as Map?;
    if (user == null) throw const NotFoundException('Profile not found');
    return CookProfileModel.fromApiUserJson(user.cast<String, dynamic>());
  }

  /// Confirmed body: `name`, `address` (both roles); `latitude`,
  /// `longitude`, `cook_description`, `availability_days`,
  /// `startAvailabilityTime`/`endAvailabilityTime` (cook-only — ignored
  /// server-side unless the token's role is COOK, harmless to always
  /// send from this cook-only screen). No `phone_number` (moved to the
  /// dedicated Request/Confirm Phone Change flow) and no photo/image
  /// field at all in the documented contract.
  ///
  /// TODO(backend): avatar upload has no confirmed endpoint — the picked
  /// `avatarPath` is deliberately not sent here; `ProfileAvatarPicker`
  /// stays wired up client-side so it's ready the moment one exists.
  Future<CookProfileModel> updateProfile(CookProfileModel profile) async {
    final timeParts = profile.availabilityTime.split('-');
    final startIso = timeParts.length == 2 ? _hhmmToIsoDateTime(timeParts[0]) : null;
    final endIso = timeParts.length == 2 ? _hhmmToIsoDateTime(timeParts[1]) : null;

    await _apiClient.patch('/users/profile', data: {
      'name': profile.fullName,
      'address': profile.address,
      'latitude': profile.latitude,
      'longitude': profile.longitude,
      'cook_description': profile.bio,
      if (profile.availabilityDays.isNotEmpty)
        'availability_days': profile.availabilityDays,
      if (startIso != null) 'startAvailabilityTime': startIso,
      if (endIso != null) 'endAvailabilityTime': endIso,
    });

    // No response body documented — echo the submitted profile back.
    return profile;
  }

  /// `"HH:mm"` → a fixed-date UTC ISO datetime, matching the confirmed
  /// `startAvailabilityTime`/`endAvailabilityTime` shape (only the
  /// time-of-day is meaningful — mirrors `timeOfDayToDateTime`'s anchor
  /// date, which this datasource can't import directly since that helper
  /// needs Flutter's `TimeOfDay` and this layer stays Flutter-free).
  String? _hhmmToIsoDateTime(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime.utc(2024, 1, 1, hour, minute).toIso8601String();
  }
}
