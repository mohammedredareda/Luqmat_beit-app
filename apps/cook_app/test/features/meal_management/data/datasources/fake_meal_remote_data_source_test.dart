import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/features/meal_management/data/models/meal_model.dart';
import 'package:cook_app/shared/current_cook_id.dart';
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
    isActive: true,
    price: 35,
  );

  test('createMeal appends and is retrievable via getMyMeals and getMealById', () async {
    await dataSource.createMeal(newMeal);

    final meals = await dataSource.getMyMeals(currentCookId);
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

  test('deleteMeal soft-deletes: excluded from getMyMeals and getMealById', () async {
    await dataSource.deleteMeal('meal-1');

    final meals = await dataSource.getMyMeals(currentCookId);
    expect(meals.any((m) => m.id == 'meal-1'), isFalse);

    final byId = await dataSource.getMealById('meal-1');
    expect(byId, isNull);
  });
}
