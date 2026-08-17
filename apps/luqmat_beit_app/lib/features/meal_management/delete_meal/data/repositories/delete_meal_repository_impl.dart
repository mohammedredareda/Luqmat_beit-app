import 'package:core/core.dart';

import '../../../data/datasources/meal_remote_data_source.dart';
import '../../domain/repositories/delete_meal_repository.dart';

class DeleteMealRepositoryImpl implements DeleteMealRepository {
  DeleteMealRepositoryImpl(this._dataSource);

  final MealRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteMeal(String mealId) {
    return guard(() => _dataSource.deleteMeal(mealId));
  }
}
