import 'package:core/core.dart';

import '../entities/search_result_item.dart';

/// CU-08 (Search & Filters) — the one story with real cursor pagination, so
/// unlike most feature repositories this returns a [PaginatedResult] rather
/// than a plain list. `filters` stays a loosely-typed map (sort key,
/// optional categoryId, `types`) so the mock datasource and the real
/// `search_remote_data_source.dart` can evolve the filter vocabulary
/// without changing this signature. A page can mix result kinds (meals,
/// offers, cooks, returned meals) — see [SearchResultItem].
abstract class SearchRepository {
  Future<Result<PaginatedResult<SearchResultItem>>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
