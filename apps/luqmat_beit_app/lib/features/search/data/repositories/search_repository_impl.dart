import 'package:core/core.dart';

import '../../domain/entities/search_result_item.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_data_source.dart';
import '../datasources/search_mock_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl({SearchDataSource? dataSource})
      : _dataSource = dataSource ?? SearchMockDataSource();

  final SearchDataSource _dataSource;

  @override
  Future<Result<PaginatedResult<SearchResultItem>>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() => _dataSource.search(
          query: query,
          filters: filters,
          cursor: cursor,
          pageSize: pageSize,
        ));
  }
}
