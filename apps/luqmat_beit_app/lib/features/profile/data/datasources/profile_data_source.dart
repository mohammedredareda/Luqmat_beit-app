import '../../domain/entities/customer_profile_entity.dart';

abstract class ProfileDataSource {
  Future<CustomerProfileEntity> getProfile();

  Future<CustomerProfileEntity> updateProfile({
    required String name,
    required String address,
  });
}
