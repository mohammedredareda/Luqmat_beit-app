import 'package:core/core.dart';

abstract class SearchDataSource {
  Future<PaginatedResult<MealEntity>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });
}
