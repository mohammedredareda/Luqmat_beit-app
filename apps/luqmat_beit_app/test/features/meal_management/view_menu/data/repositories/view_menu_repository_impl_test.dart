import 'package:luqmat_beit_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:luqmat_beit_app/features/meal_management/view_menu/data/repositories/view_menu_repository_impl.dart';
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
    final result = await repository.getMyMeals(currentCookId, pageSize: 100);

    expect(result, isA<Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>>());
    final data =
        (result as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isFalse);
    expect(data.page.items, isNotEmpty);
    // One seeded meal (lentil soup) is individually Stopped (CK-24).
    expect(data.page.items.any((m) => m.isStopped), isTrue);
    expect(
      data.page.items.any((m) => m.computeIsActive(
            withinAvailabilityWindow: true,
            cookIsSellingPaused: data.isSellingPaused,
          )),
      isTrue,
    );
  });

  test('setSellingPaused(true) pauses the kitchen and every meal becomes inactive', () async {
    final pauseResult = await repository.setSellingPaused(cookId: currentCookId, isPaused: true);
    expect((pauseResult as Success<bool>).data, isTrue);

    final menuResult = await repository.getMyMeals(currentCookId, pageSize: 100);
    final data =
        (menuResult as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isTrue);
    expect(
      data.page.items.every((m) => !m.computeIsActive(
            withinAvailabilityWindow: true,
            cookIsSellingPaused: data.isSellingPaused,
          )),
      isTrue,
    );
  });

  test('resuming selling does not resurrect a meal that is independently inactive', () async {
    await repository.setSellingPaused(cookId: currentCookId, isPaused: true);
    await repository.setSellingPaused(cookId: currentCookId, isPaused: false);

    final menuResult = await repository.getMyMeals(currentCookId, pageSize: 100);
    final data =
        (menuResult as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>).data;
    expect(data.isSellingPaused, isFalse);

    final lentilSoup = data.page.items.firstWhere((m) => m.name.contains('عدس'));
    expect(lentilSoup.isStopped, isTrue);
    expect(
      lentilSoup.computeIsActive(withinAvailabilityWindow: true, cookIsSellingPaused: false),
      isFalse,
    );

    final otherwiseActiveMeal = data.page.items.firstWhere((m) => m.name.contains('كبسة'));
    expect(
      otherwiseActiveMeal.computeIsActive(withinAvailabilityWindow: true, cookIsSellingPaused: false),
      isTrue,
    );
  });

  test('getMyMeals paginates: first page respects pageSize and hasMore', () async {
    final result = await repository.getMyMeals(currentCookId, pageSize: 5);
    final data =
        (result as Success<({PaginatedResult<MealEntity> page, bool isSellingPaused})>).data;
    expect(data.page.items, hasLength(5));
    expect(data.page.hasMore, isTrue);
    expect(data.page.nextCursor, isNotNull);
  });
}
