import 'package:core/core.dart';

import '../repositories/favorites_repository.dart';

class GetFavoriteMeals {
  const GetFavoriteMeals(this._repository);

  final FavoritesRepository _repository;

  Future<Result<List<MealEntity>>> call() => _repository.getFavoriteMeals();
}
