import 'package:core/core.dart';

import '../../../home/domain/entities/home_feed_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({required FavoritesRemoteDataSource dataSource})
      : _dataSource = dataSource;

  final FavoritesRemoteDataSource _dataSource;

  @override
  Future<Result<List<MealEntity>>> getFavoriteMeals() {
    return guard(() => _dataSource.getFavoriteMeals());
  }

  @override
  Future<Result<List<ChefSummaryEntity>>> getFollowedChefs() {
    return guard(() => _dataSource.getFollowedChefs());
  }

  @override
  Future<Result<void>> unfavoriteMeal(String mealId) {
    return guard(() => _dataSource.unfavoriteMeal(mealId));
  }

  @override
  Future<Result<void>> unfollowChef(String chefId) {
    return guard(() => _dataSource.unfollowChef(chefId));
  }
}
