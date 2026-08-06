import 'package:core/core.dart';

import '../repositories/favorites_repository.dart';

class UnfavoriteMeal {
  const UnfavoriteMeal(this._repository);

  final FavoritesRepository _repository;

  Future<Result<void>> call(String mealId) => _repository.unfavoriteMeal(mealId);
}
