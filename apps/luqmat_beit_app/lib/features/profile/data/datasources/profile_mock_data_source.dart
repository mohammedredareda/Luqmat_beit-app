import '../../domain/entities/customer_profile_entity.dart';
import 'profile_data_source.dart';

/// Stands in for `profile_remote_data_source.dart` until a backend exists.
/// Holds the profile in memory for the session so edits made via "تعديل
/// الملف الشخصي" actually persist while the app is running.
class ProfileMockDataSource implements ProfileDataSource {
  CustomerProfileEntity _profile = const CustomerProfileEntity(
    name: 'أحمد الأحمد',
    phone: '0791234567',
    address: 'عمّان، شارع الجامعة، عمارة 12',
    completedOrdersCount: 8,
    favoritesCount: 4,
  );

  @override
  Future<CustomerProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  @override
  Future<CustomerProfileEntity> updateProfile({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profile = _profile.copyWith(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
    return _profile;
  }
}
