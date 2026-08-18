import 'package:core/core.dart';

import '../../../cart/domain/repositories/cart_repository.dart';
import '../../domain/repositories/meal_details_repository.dart';
import '../datasources/meal_details_data_source.dart';
import '../datasources/meal_details_mock_data_source.dart';

class MealDetailsRepositoryImpl implements MealDetailsRepository {
  MealDetailsRepositoryImpl({
    required CartRepository cartRepository,
    MealDetailsDataSource? dataSource,
  })  : _cartRepository = cartRepository,
        _dataSource = dataSource ?? MealDetailsMockDataSource();

  final CartRepository _cartRepository;
  final MealDetailsDataSource _dataSource;

  @override
  Future<Result<MealEntity>> getMealById(String mealId) {
    return guard(() => _dataSource.getMealById(mealId));
  }

  /// Delegates to the real (in-memory) [CartRepository] — so an item added
  /// here actually shows up on the Cart screen, instead of the earlier
  /// no-op stub that only reported a fake success.
  @override
  Future<Result<void>> addToCart({
    required String mealId,
    required String sellingOptionId,
    required int quantity,
    String? note,
  }) async {
    final mealResult = await getMealById(mealId);
    return mealResult.fold(
      (meal) {
        final sellingOption = meal.sellingOptions.firstWhere(
          (option) => option.id == sellingOptionId,
          orElse: () => meal.sellingOptions.first,
        );
        return _cartRepository.addItem(
          meal: meal,
          sellingOption: sellingOption,
          quantity: quantity,
          note: note,
        );
      },
      (exception) => Result.failure(exception),
    );
  }

  @override
  Future<Result<void>> setFavorite(String mealId, bool isFavorite) {
    return guard(() => _dataSource.setFavorite(mealId, isFavorite));
  }

  @override
  Future<Result<void>> reportMeal(String mealId, String message) {
    return guard(() => _dataSource.reportMeal(mealId, message));
  }
}
