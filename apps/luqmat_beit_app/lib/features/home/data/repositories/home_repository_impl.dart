import 'package:core/core.dart';

import '../../domain/entities/home_feed_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';
import '../datasources/home_mock_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({HomeDataSource? dataSource})
      : _dataSource = dataSource ?? HomeMockDataSource();

  final HomeDataSource _dataSource;

  @override
  Future<Result<HomeFeedEntity>> getHomeFeed() {
    return guard(() => _dataSource.getHomeFeed());
  }
}
