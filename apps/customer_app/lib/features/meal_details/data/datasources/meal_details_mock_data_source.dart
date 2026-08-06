import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'meal_details_data_source.dart';

/// Stands in for `meal_details_remote_data_source.dart` until a backend
/// exists. Same call shape a real Dio-backed datasource would have, so
/// swapping it in later doesn't touch the repository.
class MealDetailsMockDataSource implements MealDetailsDataSource {
  @override
  Future<MealEntity> getMealById(String mealId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return SampleCatalog.mealById(mealId);
  }

  /// No real cart persistence yet — the `cart` feature owns that. This is
  /// a mock no-op that always "succeeds".
  Future<void> addToCart({
    required String mealId,
    required String sellingOptionId,
    required int quantity,
    String? note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> setFavorite(String mealId, bool isFavorite) async {
    await Future.delayed(const Duration(milliseconds: 150));
  }
}
