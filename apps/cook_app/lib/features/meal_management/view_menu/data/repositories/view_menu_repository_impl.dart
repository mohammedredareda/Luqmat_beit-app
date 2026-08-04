import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_meal_remote_data_source.dart';
import '../../domain/repositories/view_menu_repository.dart';

@LazySingleton(as: ViewMenuRepository)
class ViewMenuRepositoryImpl implements ViewMenuRepository {
  ViewMenuRepositoryImpl(this._dataSource);

  final FakeMealRemoteDataSource _dataSource;

  @override
  Future<Result<({List<MealEntity> meals, bool isSellingPaused})>> getMyMeals(
    String cookId,
  ) {
    return guard(() async {
      final models = await _dataSource.getMyMeals(cookId);
      final isPaused = await _dataSource.isSellingPaused(cookId);
      return (
        meals: models.map((m) => m.toEntity()).toList(),
        isSellingPaused: isPaused,
      );
    });
  }

  @override
  Future<Result<bool>> setSellingPaused({
    required String cookId,
    required bool isPaused,
  }) {
    return guard(() => _dataSource.setSellingPaused(cookId, isPaused));
  }
}
