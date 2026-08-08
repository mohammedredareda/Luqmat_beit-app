import 'package:core/core.dart';

import '../repositories/meal_details_repository.dart';

class AddMealToCart {
  const AddMealToCart(this._repository);

  final MealDetailsRepository _repository;

  Future<Result<void>> call({
    required String mealId,
    required String sellingOptionId,
    required int quantity,
    String? note,
  }) {
    return _repository.addToCart(
      mealId: mealId,
      sellingOptionId: sellingOptionId,
      quantity: quantity,
      note: note,
    );
  }
}
