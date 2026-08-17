import 'package:core/core.dart';

import '../../domain/entities/customer_profile_entity.dart';
import 'profile_data_source.dart';

/// Real implementation. There is no `GET` "my profile" endpoint in the
/// backend at all — only `POST /auth/register` and `PUT /user/{id}` (edit
/// profile) ever hand back a user object — so `getProfile` is assembled
/// from [UserProfileCache] (whatever name/phone/address registration or a
/// previous edit left behind) rather than fetched. `completedOrdersCount`/
/// `favoritesCount`/`avatarUrl` have no backend source at all yet and stay
/// at 0/null.
class ProfileRemoteDataSource implements ProfileDataSource {
  ProfileRemoteDataSource(this._apiClient, this._tokenStorage, this._profileCache);

  final ApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;
  final UserProfileCache _profileCache;

  @override
  Future<CustomerProfileEntity> getProfile() async {
    final cached = _profileCache.read();
    return CustomerProfileEntity(
      name: cached.name ?? '',
      phone: cached.phone ?? '',
      address: cached.address ?? '',
      completedOrdersCount: 0,
      favoritesCount: 0,
    );
  }

  @override
  Future<CustomerProfileEntity> updateProfile({
    required String name,
    required String address,
  }) async {
    final token = await _tokenStorage.readAccessToken();
    final claims = token != null ? decodeJwtPayload(token) : const {};
    final id = (claims['sub'] ?? claims['id'] ?? '').toString();

    await _apiClient.put('/user/$id', data: {
      'name': name,
      'addresses': address,
    });

    await _profileCache.save(name: name, address: address);
    return getProfile();
  }
}
