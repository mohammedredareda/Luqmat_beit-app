import 'package:core/core.dart';

import '../../../data/datasources/fake_meal_remote_data_source.dart';
import '../../domain/repositories/delete_meal_repository.dart';

class DeleteMealRepositoryImpl implements DeleteMealRepository {
  DeleteMealRepositoryImpl(this._dataSource);

  final FakeMealRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteMeal(String mealId) {
    return guard(() => _dataSource.deleteMeal(mealId));
  }
}
