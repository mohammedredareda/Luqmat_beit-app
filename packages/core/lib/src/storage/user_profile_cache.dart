import 'local_cache_box.dart';

/// The backend has no `GET` "my profile" endpoint at all — only
/// registration and `PUT /user/{id}` (edit profile) ever hand back a user
/// object. This caches whatever fields we've actually seen (at
/// registration, and after a successful profile edit) locally, so the
/// profile screen shows the real values instead of always falling back to
/// placeholder text. Logging in on a device that never registered/edited
/// here (e.g. a fresh install with an existing account) still has nothing
/// to show beyond what the JWT carries — that gap only closes once the
/// backend adds a real "get my profile" endpoint.
///
/// [latitude]/[longitude] are cached here too — `POST
/// /user/customer/order/confirm` requires delivery coordinates on every
/// call (confirmed against the live backend) but checkout collects no
/// location of its own, so the registration-time coordinates are reused as
/// a best-effort delivery location.
class UserProfileCache {
  static const _key = 'self';

  Future<void> save({
    String? name,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
  }) async {
    final box = LocalCacheBox.box(LocalCacheBoxNames.userProfile);
    final existing = Map<String, dynamic>.from(
      box.get(_key, defaultValue: const {}) as Map,
    );
    if (name != null) existing['name'] = name;
    if (phone != null) existing['phone'] = phone;
    if (address != null) existing['address'] = address;
    if (latitude != null) existing['latitude'] = latitude;
    if (longitude != null) existing['longitude'] = longitude;
    await box.put(_key, existing);
  }

  ({String? name, String? phone, String? address, double? latitude, double? longitude}) read() {
    final box = LocalCacheBox.box(LocalCacheBoxNames.userProfile);
    final raw = box.get(_key) as Map?;
    if (raw == null) {
      return (name: null, phone: null, address: null, latitude: null, longitude: null);
    }
    return (
      name: raw['name'] as String?,
      phone: raw['phone'] as String?,
      address: raw['address'] as String?,
      latitude: (raw['latitude'] as num?)?.toDouble(),
      longitude: (raw['longitude'] as num?)?.toDouble(),
    );
  }

  Future<void> clear() async {
    await LocalCacheBox.box(LocalCacheBoxNames.userProfile).delete(_key);
  }
}
