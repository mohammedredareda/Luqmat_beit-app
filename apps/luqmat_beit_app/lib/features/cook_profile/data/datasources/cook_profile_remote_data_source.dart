import 'package:core/core.dart';
import 'package:dio/dio.dart' show MultipartFile;

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
    final model = CookProfileModel.fromApiUserJson(user.cast<String, dynamic>());
    // `image` comes back host-relative from this endpoint, unlike every
    // other endpoint's already-absolute image URLs — without this,
    // `Image.network` throws "No host specified in URI".
    return model.copyWith(avatarUrl: _apiClient.resolveAssetUrl(model.avatarUrl));
  }

  /// Confirmed body: `name`, `address` (both roles); `latitude`,
  /// `longitude`, `cook_description`, `availability_days`,
  /// `startAvailabilityTime`/`endAvailabilityTime` (cook-only — ignored
  /// server-side unless the token's role is COOK, harmless to always
  /// send from this cook-only screen). No `phone_number` (moved to the
  /// dedicated Request/Confirm Phone Change flow).
  ///
  /// Avatar upload: a *second*, separate `PATCH` carrying only the `image`
  /// multipart field — the same field name `GET /users/profile` returns
  /// the photo under, and the same one `meal`/`create`/`edit` uploads use
  /// ([MealRemoteDataSource]). Only sent when [CookProfileModel.avatarUrl]
  /// is a local file path (a freshly picked-and-cropped photo, per
  /// [_isLocalPath]) — an already-`http(s)://` value means the cook didn't
  /// touch the avatar this edit, so there's nothing new to upload.
  ///
  /// Deliberately kept out of the request above rather than bundled in as
  /// one multipart call — `multipart/form-data` has no numeric type, so
  /// `latitude`/`longitude` would arrive at the backend as strings and
  /// fail its `@IsNumber` validation ("latitude/longitude must be a
  /// number") if sent alongside the image. Two PATCHes (both partial
  /// updates) sidesteps that instead of guessing at a dedicated upload
  /// endpoint that isn't confirmed to exist.
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

    final avatarPath = profile.avatarUrl;
    final hasNewAvatar = avatarPath != null && avatarPath.isNotEmpty && _isLocalPath(avatarPath);
    if (hasNewAvatar) {
      await _apiClient.patch(
        '/users/profile',
        data: {'image': await MultipartFile.fromFile(avatarPath)},
        isFormData: true,
      );
    }

    // No response body documented — echo the submitted profile back.
    return profile;
  }

  bool _isLocalPath(String path) => !path.startsWith('http://') && !path.startsWith('https://');

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
