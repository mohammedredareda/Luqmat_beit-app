import 'package:core/core.dart';

import '../../../../meal_management/data/datasources/fake_meal_remote_data_source.dart';
import '../../domain/repositories/selectable_meals_repository.dart';

class SelectableMealsRepositoryImpl implements SelectableMealsRepository {
  SelectableMealsRepositoryImpl(this._dataSource);

  final FakeMealRemoteDataSource _dataSource;

  @override
  Future<Result<List<MealEntity>>> getSelectableMeals(String cookId) {
    return guard(() async {
      final models = await _dataSource.getAllMyMeals(cookId);
      return models
          .where((m) => !m.isStopped && m.deletedAt == null)
          .map((m) => m.toEntity())
          .toList();
    });
  }

  @override
  Future<Result<MealEntity>> getMealById(String mealId) {
    return guard(() async {
      final model = await _dataSource.getMealById(mealId);
      if (model == null) throw const NotFoundException('Meal not found');
      return model.toEntity();
    });
  }
}
