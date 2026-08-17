import 'package:core/core.dart';

import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this._dataSource);

  final CategoriesRemoteDataSource _dataSource;

  @override
  Future<Result<List<FoodCategoryEntity>>> getCategories() {
    return guard(() => _dataSource.getCategories());
  }
}
