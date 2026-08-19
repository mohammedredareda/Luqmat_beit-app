import 'package:core/core.dart';

import '../entities/chef_profile_entity.dart';

abstract class ChefRepository {
  Future<Result<ChefProfileEntity>> getChefProfile(String chefId);

  /// [wasFollowing] is the state *before* the toggle, so a real datasource
  /// knows whether to call the follow or unfollow endpoint (the backend
  /// exposes them separately, not as one toggle).
  Future<Result<void>> toggleFollow(String chefId,
      {required bool wasFollowing});
}
