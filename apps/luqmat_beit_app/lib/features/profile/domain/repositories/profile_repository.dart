import 'package:core/core.dart';

import '../entities/customer_profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<CustomerProfileEntity>> getProfile();

  Future<Result<CustomerProfileEntity>> updateProfile({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
  });
}
