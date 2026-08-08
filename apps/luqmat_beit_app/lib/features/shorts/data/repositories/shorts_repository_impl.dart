import 'package:core/core.dart';

import '../../domain/entities/short_entity.dart';
import '../../domain/repositories/shorts_repository.dart';
import '../datasources/shorts_mock_data_source.dart';

class ShortsRepositoryImpl implements ShortsRepository {
  ShortsRepositoryImpl({ShortsMockDataSource? dataSource})
      : _dataSource = dataSource ?? ShortsMockDataSource();

  final ShortsMockDataSource _dataSource;

  @override
  Future<Result<List<ShortEntity>>> getShorts() {
    return guard(() => _dataSource.getShorts());
  }

  @override
  Future<Result<void>> toggleLike(String shortId) {
    return guard(() => _dataSource.toggleLike(shortId));
  }
}
