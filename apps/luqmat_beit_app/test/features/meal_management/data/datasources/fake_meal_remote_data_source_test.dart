import 'package:luqmat_beit_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:luqmat_beit_app/features/meal_management/data/models/meal_model.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
  });

  const newMeal = MealModel(
    id: 'meal-new',
    cookId: currentCookId,
    name: 'مسخن دجاج',
    description: 'خبز طابون مع دجاج وبصل وسماق',
    imageUrl: 'https://example.com/musakhan.png',
    price: 35,
  );

  test('createMeal appends and is retrievable via getAllMyMeals and getMealById', () async {
    await dataSource.createMeal(newMeal);

    final meals = await dataSource.getAllMyMeals(currentCookId);
    expect(meals.any((m) => m.id == 'meal-new'), isTrue);

    final byId = await dataSource.getMealById('meal-new');
    expect(byId, isNotNull);
    expect(byId!.name, 'مسخن دجاج');
  });

  test('updateMeal replaces the meal in place', () async {
    await dataSource.createMeal(newMeal);

    final updated = newMeal.copyWith(name: 'مسخن دجاج محدث', price: 40);
    await dataSource.updateMeal(updated);

    final byId = await dataSource.getMealById('meal-new');
    expect(byId!.name, 'مسخن دجاج محدث');
    expect(byId.price, 40);
  });

  test('updateMeal on an unknown id throws NotFoundException', () async {
    expect(
      () => dataSource.updateMeal(newMeal),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleteMeal on an unknown id throws NotFoundException', () async {
    expect(
      () => dataSource.deleteMeal('does-not-exist'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleteMeal soft-deletes: excluded from getAllMyMeals and getMealById', () async {
    await dataSource.deleteMeal('meal-1');

    final meals = await dataSource.getAllMyMeals(currentCookId);
    expect(meals.any((m) => m.id == 'meal-1'), isFalse);

    final byId = await dataSource.getMealById('meal-1');
    expect(byId, isNull);
  });

  test('getMyMeals returns one cursor page and honors pageSize/hasMore', () async {
    final firstPage = await dataSource.getMyMeals(currentCookId, pageSize: 10);
    expect(firstPage.items, hasLength(10));
    expect(firstPage.hasMore, isTrue);
    expect(firstPage.nextCursor, isNotNull);

    final secondPage = await dataSource.getMyMeals(
      currentCookId,
      cursor: firstPage.nextCursor,
      pageSize: 10,
    );
    expect(secondPage.items, hasLength(10));
    // No overlap between consecutive pages.
    final firstIds = firstPage.items.map((m) => m.id).toSet();
    expect(secondPage.items.any((m) => firstIds.contains(m.id)), isFalse);
  });

  test('getMyMeals reaches hasMore: false once every meal has been paged through', () async {
    final all = await dataSource.getAllMyMeals(currentCookId);

    String? cursor;
    var seen = 0;
    PaginatedResult<MealModel> page;
    do {
      page = await dataSource.getMyMeals(currentCookId, cursor: cursor, pageSize: 15);
      seen += page.items.length;
      cursor = page.nextCursor;
    } while (page.hasMore);

    expect(seen, all.length);
  });
}
