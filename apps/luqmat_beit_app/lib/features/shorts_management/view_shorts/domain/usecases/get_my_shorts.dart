import 'package:core/core.dart';

import '../../../shared/domain/entities/short_management_entity.dart';
import '../repositories/view_shorts_repository.dart';

class GetMyShorts {
  GetMyShorts(this._repository);

  final ViewShortsRepository _repository;

  Future<Result<PaginatedResult<ShortManagementEntity>>> call(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) =>
      _repository.getMyShorts(cookId, cursor: cursor, pageSize: pageSize);
}
