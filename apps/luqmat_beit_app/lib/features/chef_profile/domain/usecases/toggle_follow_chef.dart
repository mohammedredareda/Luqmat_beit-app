import 'package:core/core.dart';

import '../repositories/chef_repository.dart';

class ToggleFollowChef {
  const ToggleFollowChef(this._repository);

  final ChefRepository _repository;

  Future<Result<void>> call(String chefId, {required bool wasFollowing}) =>
      _repository.toggleFollow(chefId, wasFollowing: wasFollowing);
}
