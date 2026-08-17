import 'package:core/core.dart';

import '../../../shared/domain/entities/short_management_entity.dart';

abstract class ViewShortsRepository {
  /// One page of the cook's own shorts, newest first. `cursor: null`
  /// requests the first page.
  Future<Result<PaginatedResult<ShortManagementEntity>>> getMyShorts(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
