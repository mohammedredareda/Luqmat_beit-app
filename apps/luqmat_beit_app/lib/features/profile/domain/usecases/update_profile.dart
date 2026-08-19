import 'package:core/core.dart';

import '../entities/customer_profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  const UpdateProfile(this._repository);

  final ProfileRepository _repository;

  Future<Result<CustomerProfileEntity>> call({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
  }) {
    return _repository.updateProfile(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
