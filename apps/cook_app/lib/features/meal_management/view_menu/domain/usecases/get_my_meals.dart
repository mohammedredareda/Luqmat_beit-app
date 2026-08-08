import 'package:core/core.dart';

import '../repositories/view_menu_repository.dart';

class GetMyMeals {
  GetMyMeals(this._repository);

  final ViewMenuRepository _repository;

  Future<Result<({PaginatedResult<MealEntity> page, bool isSellingPaused})>> call(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) =>
      _repository.getMyMeals(cookId, cursor: cursor, pageSize: pageSize);
}
