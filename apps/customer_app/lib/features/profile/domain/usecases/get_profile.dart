import 'package:core/core.dart';

import '../entities/customer_profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  const GetProfile(this._repository);

  final ProfileRepository _repository;

  Future<Result<CustomerProfileEntity>> call() => _repository.getProfile();
}
