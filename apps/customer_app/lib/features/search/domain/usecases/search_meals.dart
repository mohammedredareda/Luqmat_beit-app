import 'package:core/core.dart';

import '../repositories/search_repository.dart';

class SearchMeals {
  const SearchMeals(this._repository);

  final SearchRepository _repository;

  Future<Result<PaginatedResult<MealEntity>>> call({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return _repository.search(
      query: query,
      filters: filters,
      cursor: cursor,
      pageSize: pageSize,
    );
  }
}
