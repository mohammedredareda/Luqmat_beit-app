import 'package:core/core.dart';

import '../../../shared/data/datasources/shorts_remote_data_source.dart';
import '../../../shared/domain/entities/short_management_entity.dart';
import '../../domain/repositories/view_shorts_repository.dart';

class ViewShortsRepositoryImpl implements ViewShortsRepository {
  ViewShortsRepositoryImpl(this._dataSource);

  final ShortsRemoteDataSource _dataSource;

  @override
  Future<Result<PaginatedResult<ShortManagementEntity>>> getMyShorts(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final page = await _dataSource.getMyShorts(cookId, cursor: cursor, pageSize: pageSize);
      return page.map((m) => m.toEntity());
    });
  }
}
