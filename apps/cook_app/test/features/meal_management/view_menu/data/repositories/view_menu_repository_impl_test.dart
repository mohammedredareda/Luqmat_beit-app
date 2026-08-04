import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/meal_management/view_menu/data/repositories/view_menu_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;
  late ViewMenuRepositoryImpl repository;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
    repository = ViewMenuRepositoryImpl(dataSource);
  });

  test('getMyMeals returns Result.success with the seeded meals, kitchen active', () async {
    final result = await repository.getMyMeals(currentCookId);

    expect(result, isA<Success<({List<MealEntity> meals, bool isSellingPaused})>>());
    final data = (result as Success<({List<MealEntity> meals, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isFalse);
    expect(data.meals, isNotEmpty);
    // One seeded meal (lentil soup) is intrinsically out of stock.
    expect(data.meals.any((m) => !m.isActive), isTrue);
    expect(data.meals.any((m) => m.isActive), isTrue);
  });

  test('setSellingPaused(true) pauses the kitchen and every meal becomes inactive', () async {
    final pauseResult = await repository.setSellingPaused(cookId: currentCookId, isPaused: true);
    expect((pauseResult as Success<bool>).data, isTrue);

    final menuResult = await repository.getMyMeals(currentCookId);
    final data = (menuResult as Success<({List<MealEntity> meals, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isTrue);
    expect(data.meals.every((m) => !m.isActive), isTrue);
  });

  test('resuming selling does not resurrect a meal that is independently inactive', () async {
    await repository.setSellingPaused(cookId: currentCookId, isPaused: true);
    await repository.setSellingPaused(cookId: currentCookId, isPaused: false);

    final menuResult = await repository.getMyMeals(currentCookId);
    final data = (menuResult as Success<({List<MealEntity> meals, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isFalse);

    final lentilSoup = data.meals.firstWhere((m) => m.name.contains('عدس'));
    expect(lentilSoup.isActive, isFalse);

    final otherwiseActiveMeal = data.meals.firstWhere((m) => m.name.contains('كبسة'));
    expect(otherwiseActiveMeal.isActive, isTrue);
  });
}
