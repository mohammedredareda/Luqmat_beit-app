import 'package:core/core.dart';

import '../../domain/entities/customer_profile_entity.dart';
import 'profile_data_source.dart';
import 'profile_mock_data_source.dart';

/// Real implementation of `updateProfile` only, backed by `PUT /user/{id}`
/// (the same endpoint the Auth folder calls "edit profile"). There is no
/// `GET` profile endpoint in the backend at all, so `getProfile` keeps
/// delegating to the mock. The user id comes from decoding the stored JWT
/// (see `AuthRemoteDataSource` for the same best-effort approach — the
/// login response carries no user object either). The edit-profile request
/// has no saved example response, so the returned entity is assembled
/// locally from the request + whatever `getProfile` last had, rather than
/// parsed from a guessed response shape.
class ProfileRemoteDataSource implements ProfileDataSource {
  ProfileRemoteDataSource(this._apiClient, this._tokenStorage);

  final ApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;
  final ProfileMockDataSource _fallback = ProfileMockDataSource();

  @override
  Future<CustomerProfileEntity> getProfile() => _fallback.getProfile();

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

    final current = await _fallback.getProfile();
    return current.copyWith(name: name, address: address);
  }
}
