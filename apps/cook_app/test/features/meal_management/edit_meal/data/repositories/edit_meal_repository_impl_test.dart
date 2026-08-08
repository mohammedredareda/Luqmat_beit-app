import 'package:cook_app/features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import 'package:cook_app/features/meal_management/domain/meal_form_submission.dart';
import 'package:cook_app/features/meal_management/edit_meal/data/repositories/edit_meal_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeMealRemoteDataSource dataSource;
  late EditMealRepositoryImpl repository;

  setUp(() {
    dataSource = FakeMealRemoteDataSource();
    repository = EditMealRepositoryImpl(dataSource);
  });

  test('getMeal on a seeded id returns its data', () async {
    final result = await repository.getMeal('meal-1');

    expect(result, isA<Success<MealEntity>>());
    final meal = (result as Success<MealEntity>).data;
    expect(meal.id, 'meal-1');
    expect(meal.name, 'كبسة دجاج منزلية');
  });

  test('getMeal on an unknown id returns Result.failure(NotFoundException)', () async {
    final result = await repository.getMeal('does-not-exist');
    expect(result, isA<Failure<MealEntity>>());
    expect((result as Failure<MealEntity>).exception, isA<NotFoundException>());
  });

  test('updateMeal with a single price sets price and clears sellingOptions', () async {
    const submission = MealFormSubmission(
      name: 'كبسة دجاج محدثة',
      description: 'وصف محدث',
      imagePath: 'https://example.com/kabsa2.png',
      categoryIds: ['main_dishes'],
      preorderHours: 3,
      price: 50,
    );

    final result = await repository.updateMeal('meal-1', submission, isStopped: false);
    final meal = (result as Success<MealEntity>).data;

    expect(meal.name, 'كبسة دجاج محدثة');
    expect(meal.singlePrice, 50);
    expect(meal.sellingOptions, isEmpty);
    expect(meal.hasVariations, isFalse);
  });

  test('updateMeal with variations clears price (mutual exclusivity)', () async {
    const submission = MealFormSubmission(
      name: 'كبسة دجاج بخيارات',
      description: 'وصف محدث',
      imagePath: 'https://example.com/kabsa3.png',
      categoryIds: ['main_dishes'],
      preorderHours: 3,
      sellingOptions: [
        MealVariationInput(label: 'صغير', price: 30),
        MealVariationInput(label: 'كبير', price: 55),
      ],
    );

    final result = await repository.updateMeal('meal-1', submission, isStopped: false);
    final meal = (result as Success<MealEntity>).data;

    expect(meal.singlePrice, isNull);
    expect(meal.hasVariations, isTrue);
    expect(meal.sellingOptions, hasLength(2));
  });

  test('a subsequent getMeal reflects the update', () async {
    const submission = MealFormSubmission(
      name: 'اسم جديد',
      description: 'وصف جديد',
      imagePath: 'https://example.com/new.png',
      categoryIds: [],
      preorderHours: 2,
      price: 22,
    );

    await repository.updateMeal('meal-1', submission, isStopped: true);

    final result = await repository.getMeal('meal-1');
    final meal = (result as Success<MealEntity>).data;
    expect(meal.name, 'اسم جديد');
    expect(meal.isStopped, isTrue);
  });
}
