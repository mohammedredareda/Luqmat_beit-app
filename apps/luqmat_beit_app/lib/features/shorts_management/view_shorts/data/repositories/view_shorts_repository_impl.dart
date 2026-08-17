import 'package:core/core.dart';

import '../../../shared/data/datasources/fake_shorts_remote_data_source.dart';
import '../../../shared/domain/entities/short_management_entity.dart';
import '../../domain/repositories/view_shorts_repository.dart';

class ViewShortsRepositoryImpl implements ViewShortsRepository {
  ViewShortsRepositoryImpl(this._dataSource);

  final FakeShortsRemoteDataSource _dataSource;

  /// [FakeShortsRemoteDataSource.getMyShorts] has no real pagination of its
  /// own (it's a small in-memory list), so page slicing happens here —
  /// `cursor` is treated as a page number string, the same stand-in
  /// `MealRemoteDataSource.getMyMeals` uses until a real opaque cursor
  /// exists.
  @override
  Future<Result<PaginatedResult<ShortManagementEntity>>> getMyShorts(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final all = await _dataSource.getMyShorts(cookId);
      final page = cursor == null ? 1 : int.parse(cursor);
      final start = (page - 1) * pageSize;
      if (start >= all.length) {
        return const PaginatedResult(items: [], hasMore: false);
      }
      final end = (start + pageSize).clamp(0, all.length);
      final items = all.sublist(start, end).map((m) => m.toEntity()).toList();
      return PaginatedResult(
        items: items,
        hasMore: end < all.length,
        nextCursor: end < all.length ? '${page + 1}' : null,
      );
    });
  }
}
