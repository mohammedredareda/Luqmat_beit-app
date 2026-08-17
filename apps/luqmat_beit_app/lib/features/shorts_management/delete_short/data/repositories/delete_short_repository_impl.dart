import 'package:core/core.dart';

import '../../../shared/data/datasources/fake_shorts_remote_data_source.dart';
import '../../domain/repositories/delete_short_repository.dart';

class DeleteShortRepositoryImpl implements DeleteShortRepository {
  DeleteShortRepositoryImpl(this._dataSource);

  final FakeShortsRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteShort(String shortId) {
    return guard(() => _dataSource.deleteShort(shortId));
  }
}
