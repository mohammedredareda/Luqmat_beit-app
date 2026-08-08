import 'package:core/core.dart';

import '../../../data/datasources/fake_meal_remote_data_source.dart';
import '../../domain/repositories/view_menu_repository.dart';

class ViewMenuRepositoryImpl implements ViewMenuRepository {
  ViewMenuRepositoryImpl(this._dataSource);

  final FakeMealRemoteDataSource _dataSource;

  @override
  Future<Result<({PaginatedResult<MealEntity> page, bool isSellingPaused})>> getMyMeals(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) {
    return guard(() async {
      final page = await _dataSource.getMyMeals(cookId, cursor: cursor, pageSize: pageSize);
      final isPaused = await _dataSource.isSellingPaused(cookId);
      return (
        page: page.map((m) => m.toEntity()),
        isSellingPaused: isPaused,
      );
    });
  }

  @override
  Future<Result<bool>> setSellingPaused({
    required String cookId,
    required bool isPaused,
  }) {
    return guard(() => _dataSource.setSellingPaused(cookId, isPaused));
  }
}
