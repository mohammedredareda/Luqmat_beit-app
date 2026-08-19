import 'package:core/core.dart';

import '../repositories/meal_details_repository.dart';

class AddReturnedMealToCart {
  const AddReturnedMealToCart(this._repository);

  final MealDetailsRepository _repository;

  Future<Result<void>> call({required String returnedMealId, required int count}) {
    return _repository.addReturnedMealToCart(returnedMealId: returnedMealId, count: count);
  }
}
