import 'package:cook_app/features/meal_management/create_meal/data/repositories/create_meal_repository_impl.dart';
import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/meal_management/domain/meal_form_submission.dart';
import 'package:cook_app/features/meal_management/view_menu/data/repositories/view_menu_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;
  late CreateMealRepositoryImpl repository;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
    repository = CreateMealRepositoryImpl(dataSource);
  });

  const submission = MealFormSubmission(
    name: 'فتوش',
    description: 'سلطة خضار مقرمشة مع خبز محمص',
    imagePath: 'https://example.com/fattoush.png',
    categoryIds: ['appetizers'],
    preorderHours: 1,
    price: 18,
  );

  test('createMeal returns Result.success with the new meal', () async {
    final result = await repository.createMeal(submission);

    expect(result, isA<Success<MealEntity>>());
    final meal = (result as Success<MealEntity>).data;
    expect(meal.name, 'فتوش');
    expect(meal.singlePrice, 18);
    expect(
      meal.computeIsActive(withinAvailabilityWindow: true, cookIsSellingPaused: false),
      isTrue,
    );
  });

  test('the created meal is visible via view_menu reading the same shared datasource', () async {
    await repository.createMeal(submission);

    final viewMenuRepository = ViewMenuRepositoryImpl(dataSource);
    final result = await viewMenuRepository.getMyMeals(currentCookId, pageSize: 100);
    final meals =
        (result as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>)
            .data
            .page
            .items;

    expect(meals.any((m) => m.name == 'فتوش'), isTrue);
  });
}
