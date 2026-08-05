import 'package:core/core.dart';

abstract class ViewMenuRepository {
  /// The cook's own meals (one page) plus whether the cook has paused
  /// kitchen-wide selling (CK-10) — bundled together since a real API
  /// response would return both in one payload. `cursor: null` requests
  /// the first page.
  Future<Result<({PaginatedResult<MealEntity> page, bool isSellingPaused})>> getMyMeals(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  });

  Future<Result<bool>> setSellingPaused({
    required String cookId,
    required bool isPaused,
  });
}
