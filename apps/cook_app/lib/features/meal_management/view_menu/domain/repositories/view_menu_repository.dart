import 'package:core/core.dart';

abstract class ViewMenuRepository {
  /// The cook's own meals plus whether the cook has paused kitchen-wide
  /// selling (CK-10) — bundled together since a real API response would
  /// return both in one payload.
  Future<Result<({List<MealEntity> meals, bool isSellingPaused})>> getMyMeals(
    String cookId,
  );

  Future<Result<bool>> setSellingPaused({
    required String cookId,
    required bool isPaused,
  });
}
