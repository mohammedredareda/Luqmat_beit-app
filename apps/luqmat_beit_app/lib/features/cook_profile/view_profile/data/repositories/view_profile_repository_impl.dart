import 'package:core/core.dart';

import '../../../data/datasources/cook_profile_remote_data_source.dart';
import '../../../domain/cook_profile_details.dart';
import '../../domain/repositories/view_profile_repository.dart';

class ViewProfileRepositoryImpl implements ViewProfileRepository {
  ViewProfileRepositoryImpl(this._dataSource);

  final CookProfileRemoteDataSource _dataSource;

  @override
  Future<Result<CookProfileDetails>> getProfile(String cookId) {
    return guard(() async {
      final model = await _dataSource.getProfile(cookId);
      return model.toDetails();
    });
  }
}
