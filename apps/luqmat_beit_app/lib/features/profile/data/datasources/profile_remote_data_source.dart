import 'package:core/core.dart';

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
/// stats. `avatarUrl` comes from the response's `image` field with no
/// upload endpoint to write it back (see `updateProfile`'s doc comment).
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
      avatarUrl: user['image'] as String?,
      latitude: double.tryParse(user['latitude']?.toString() ?? ''),
      longitude: double.tryParse(user['longitude']?.toString() ?? ''),
    );
  }

  /// Confirmed body: `name`, `address`, `latitude`, `longitude` — the same
  /// role-agnostic fields `CookProfileRemoteDataSource.updateProfile` sends
  /// (minus the cook-only ones). No response body documented, so this
  /// re-fetches rather than fabricating one.
  ///
  /// TODO(backend): avatar upload has no confirmed endpoint on either
  /// role — not sent here.
  @override
  Future<CustomerProfileEntity> updateProfile({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    await _apiClient.patch('/users/profile', data: {
      'name': name,
      'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });

    await _profileCache.save(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
    return getProfile();
  }
}
