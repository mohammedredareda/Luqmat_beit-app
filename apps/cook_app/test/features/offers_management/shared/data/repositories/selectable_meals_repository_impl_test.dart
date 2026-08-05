import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/offers_management/shared/data/repositories/selectable_meals_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;
  late SelectableMealsRepositoryImpl repository;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
    repository = SelectableMealsRepositoryImpl(dataSource);
  });

  test('getSelectableMeals excludes inactive/stopped meals', () async {
    final result = await repository.getSelectableMeals(currentCookId);

    final meals = (result as Success<List<MealEntity>>).data;
    expect(meals.every((m) => m.isActive), isTrue);
    // meal-3 is seeded inactive.
    expect(meals.any((m) => m.id == 'meal-3'), isFalse);
  });

  test('getMealById on a bad id returns Failure<NotFoundException>', () async {
    final result = await repository.getMealById('does-not-exist');

    expect(result, isA<Failure<MealEntity>>());
    expect((result as Failure<MealEntity>).exception, isA<NotFoundException>());
  });

  test('getMealById on a seeded id returns its data', () async {
    final result = await repository.getMealById('meal-1');

    expect(result, isA<Success<MealEntity>>());
    expect((result as Success<MealEntity>).data.id, 'meal-1');
  });
}
