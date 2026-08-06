import 'package:core/core.dart';

import '../entities/chef_profile_entity.dart';
import '../repositories/chef_repository.dart';

class GetChefProfile {
  const GetChefProfile(this._repository);

  final ChefRepository _repository;

  Future<Result<ChefProfileEntity>> call(String chefId) =>
      _repository.getChefProfile(chefId);
}
