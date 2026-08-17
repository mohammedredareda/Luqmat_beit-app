import 'package:core/core.dart';

abstract class CategoriesRepository {
  Future<Result<List<FoodCategoryEntity>>> getCategories();
}
