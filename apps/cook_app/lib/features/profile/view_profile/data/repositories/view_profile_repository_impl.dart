import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_cook_profile_remote_data_source.dart';
import '../../domain/repositories/view_profile_repository.dart';

@LazySingleton(as: ViewProfileRepository)
class ViewProfileRepositoryImpl implements ViewProfileRepository {
  ViewProfileRepositoryImpl(this._dataSource);

  final FakeCookProfileRemoteDataSource _dataSource;

  @override
  Future<Result<CookProfileEntity>> getProfile(String cookId) {
    return guard(() async {
      final model = await _dataSource.getProfile(cookId);
      return model.toEntity();
    });
  }
}
