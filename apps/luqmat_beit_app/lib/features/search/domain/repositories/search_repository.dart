import 'package:core/core.dart';

/// CU-08 (Search & Filters) — the one story with real cursor pagination, so
/// unlike most feature repositories this returns a [PaginatedResult] rather
/// than a plain list. `filters` stays a loosely-typed map (sort key,
/// optional categoryId) so the mock datasource and a future
/// `search_remote_data_source.dart` can evolve the filter vocabulary
/// without changing this signature.
abstract class SearchRepository {
  Future<Result<PaginatedResult<MealEntity>>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
