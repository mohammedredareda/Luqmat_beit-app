import '../../domain/entities/chef_profile_entity.dart';

abstract class ChefDataSource {
  Future<ChefProfileEntity> getChefProfile(String chefId);

  Future<void> toggleFollow(String chefId, {required bool wasFollowing});
}
