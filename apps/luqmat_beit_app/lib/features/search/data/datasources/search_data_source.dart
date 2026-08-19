import 'package:core/core.dart';

import '../../domain/entities/search_result_item.dart';

abstract class SearchDataSource {
  Future<PaginatedResult<SearchResultItem>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
