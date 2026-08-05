import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/features/meal_management/delete_meal/data/repositories/delete_meal_repository_impl.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/meal_management/view_menu/data/repositories/view_menu_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;
  late DeleteMealRepositoryImpl repository;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
    repository = DeleteMealRepositoryImpl(dataSource);
  });

  test('deleteMeal on a seeded id returns Result.success', () async {
    final result = await repository.deleteMeal('meal-1');
    expect(result, isA<Success<void>>());
  });

  test('deleteMeal on an unknown id returns Result.failure(NotFoundException)', () async {
    final result = await repository.deleteMeal('does-not-exist');
    expect(result, isA<Failure<void>>());
    expect((result as Failure<void>).exception, isA<NotFoundException>());
  });

  test('a subsequent view_menu getMyMeals excludes the deleted meal', () async {
    await repository.deleteMeal('meal-1');

    final viewMenuRepository = ViewMenuRepositoryImpl(dataSource);
    final result = await viewMenuRepository.getMyMeals(currentCookId, pageSize: 100);
    final meals =
        (result as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>)
            .data
            .page
            .items;

    expect(meals.any((m) => m.id == 'meal-1'), isFalse);
  });
}
