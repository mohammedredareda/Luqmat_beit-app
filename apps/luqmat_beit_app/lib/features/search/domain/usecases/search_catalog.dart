import 'package:core/core.dart';

import '../entities/search_result_item.dart';
import '../repositories/search_repository.dart';

/// Renamed from `SearchMeals` once the search screen grew beyond
/// meals-only results (offers/cooks/returned meals via `types`).
class SearchCatalog {
  const SearchCatalog(this._repository);

  final SearchRepository _repository;

  Future<Result<PaginatedResult<SearchResultItem>>> call({
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
