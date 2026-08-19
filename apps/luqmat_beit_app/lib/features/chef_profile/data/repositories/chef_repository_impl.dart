import 'package:core/core.dart';

import '../../domain/entities/chef_profile_entity.dart';
import '../../domain/repositories/chef_repository.dart';
import '../datasources/chef_data_source.dart';
import '../datasources/chef_mock_data_source.dart';

class ChefRepositoryImpl implements ChefRepository {
  ChefRepositoryImpl({ChefDataSource? dataSource})
      : _dataSource = dataSource ?? ChefMockDataSource();

  final ChefDataSource _dataSource;

  @override
  Future<Result<ChefProfileEntity>> getChefProfile(String chefId) {
    return guard(() => _dataSource.getChefProfile(chefId));
  }

  @override
  Future<Result<void>> toggleFollow(String chefId,
      {required bool wasFollowing}) {
    return guard(
        () => _dataSource.toggleFollow(chefId, wasFollowing: wasFollowing));
  }
}
