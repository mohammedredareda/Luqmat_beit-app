import 'package:core/core.dart';

import '../../domain/entities/customer_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_data_source.dart';
import '../datasources/profile_mock_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({ProfileDataSource? dataSource})
      : _dataSource = dataSource ?? ProfileMockDataSource();

  final ProfileDataSource _dataSource;

  @override
  Future<Result<CustomerProfileEntity>> getProfile() {
    return guard(() => _dataSource.getProfile());
  }

  @override
  Future<Result<CustomerProfileEntity>> updateProfile({
    required String name,
    required String address,
  }) {
    return guard(() => _dataSource.updateProfile(name: name, address: address));
  }
}
