import 'package:core/core.dart';
import 'package:dio/dio.dart' show MultipartFile;

import '../../domain/entities/customer_profile_entity.dart';
import 'profile_data_source.dart';

/// Real implementation backed by `/users/profile` — `GET` (confirmed live)
/// and `PATCH` (confirmed live). No `{id}` in either URL — the
/// authenticated user is resolved from the Bearer token server-side, same
/// endpoint the cook role uses (see `CookProfileRemoteDataSource`'s doc
/// comment — `name`/`address` are confirmed to apply to both roles). This
/// replaces the earlier `PUT /user/{id}` guess, which mirrored the cook
/// side's own now-abandoned guess that 404'd ("Cannot PUT") — that route
/// never existed.
///
/// `completedOrdersCount`/`favoritesCount` have no backend source at all
/// yet and stay at 0 — same honest gap the cook role has for its own
/// stats. `avatarUrl` comes from the response's `image` field (see
/// `updateProfile`'s doc comment for how it's written back).
class ProfileRemoteDataSource implements ProfileDataSource {
  ProfileRemoteDataSource(this._apiClient, this._profileCache);

  final ApiClient _apiClient;
  final UserProfileCache _profileCache;

  @override
  Future<CustomerProfileEntity> getProfile() async {
    final response = await _apiClient.get('/users/profile') as Map;
    final user = response['user'] as Map?;
    if (user == null) throw const NotFoundException('Profile not found');

    return CustomerProfileEntity(
      name: user['name'] as String? ?? '',
      phone: user['phone'] as String? ?? '',
      address: user['address'] as String? ?? '',
      completedOrdersCount: 0,
      favoritesCount: 0,
      avatarUrl: _apiClient.resolveAssetUrl(user['image'] as String?),
      latitude: double.tryParse(user['latitude']?.toString() ?? ''),
      longitude: double.tryParse(user['longitude']?.toString() ?? ''),
    );
  }

  /// Confirmed body: `name`, `address`, `latitude`, `longitude` — the same
  /// role-agnostic fields `CookProfileRemoteDataSource.updateProfile` sends
  /// (minus the cook-only ones). No response body documented, so this
  /// re-fetches rather than fabricating one.
  ///
  /// Avatar upload: a *second*, separate `PATCH` carrying only the `image`
  /// multipart field, sent only when [avatarPath] is a local file path
  /// (not an already-uploaded `http(s)://` URL). Deliberately kept out of
  /// the request above — `multipart/form-data` has no numeric type, so
  /// `latitude`/`longitude` would arrive at the backend as strings and
  /// fail its `@IsNumber` validation ("latitude/longitude must be a
  /// number") if bundled into the same multipart request. Two PATCHes
  /// (both partial updates) sidesteps that instead of guessing at a
  /// dedicated upload endpoint that isn't confirmed to exist.
  @override
  Future<CustomerProfileEntity> updateProfile({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
    String? avatarPath,
  }) async {
    await _apiClient.patch('/users/profile', data: {
      'name': name,
      'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });

    final hasNewAvatar = avatarPath != null && avatarPath.isNotEmpty && _isLocalPath(avatarPath);
    if (hasNewAvatar) {
      await _apiClient.patch(
        '/users/profile',
        data: {'image': await MultipartFile.fromFile(avatarPath)},
        isFormData: true,
      );
    }

    await _profileCache.save(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
    return getProfile();
  }

  bool _isLocalPath(String path) => !path.startsWith('http://') && !path.startsWith('https://');
}
