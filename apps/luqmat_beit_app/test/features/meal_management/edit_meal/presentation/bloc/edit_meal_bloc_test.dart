import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/meal_management/domain/meal_form_submission.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/domain/usecases/get_meal.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/domain/usecases/update_meal.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/presentation/bloc/edit_meal_bloc.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/presentation/bloc/edit_meal_event.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/presentation/bloc/edit_meal_state.dart';
import 'package:luqmat_beit_app/features/meal_management/shared/presentation/bloc/meal_submit_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetMeal extends Mock implements GetMeal {}

class _MockUpdateMeal extends Mock implements UpdateMeal {}

void main() {
  late _MockGetMeal getMeal;
  late _MockUpdateMeal updateMeal;

  setUpAll(() {
    registerFallbackValue(const MealFormSubmission(
      name: '',
      description: '',
      imagePath: '',
      categoryIds: [],
      preorderHours: 0,
    ));
  });

  setUp(() {
    getMeal = _MockGetMeal();
    updateMeal = _MockUpdateMeal();
  });

  const existingMeal = MealEntity(
    id: 'meal-1',
    cookId: 'cook-1',
    cookName: 'مطبخ أم أحمد',
    name: 'كبسة دجاج منزلية',
    description: 'وصف',
    imageUrl: 'https://example.com/kabsa.png',
    sellingOptions: [],
    singlePrice: 45,
    preparingDurationMinutes: 2,
  );

  const validFormData = EditMealFormData(
    mealId: 'meal-1',
    name: 'كبسة دجاج منزلية',
    description: 'وصف',
    preorderHoursInput: '2',
    priceInput: '45.0',
    imagePath: 'https://example.com/kabsa.png',
  );

  blocTest<EditMealBloc, EditMealState>(
    'started with a successful GetMeal emits [loading, form(prefilled)]',
    setUp: () {
      when(() => getMeal('meal-1')).thenAnswer((_) async => const Result.success(existingMeal));
    },
    build: () => EditMealBloc(getMeal, updateMeal),
    act: (bloc) => bloc.add(const EditMealEvent.started('meal-1')),
    expect: () => [
      const EditMealState.loading(),
      EditMealState.form(validFormData),
    ],
  );

  blocTest<EditMealBloc, EditMealState>(
    'started with a failing GetMeal emits [loading, loadError]',
    setUp: () {
      when(() => getMeal('meal-1')).thenAnswer(
        (_) async => const Result.failure(NotFoundException('Meal not found')),
      );
    },
    build: () => EditMealBloc(getMeal, updateMeal),
    act: (bloc) => bloc.add(const EditMealEvent.started('meal-1')),
    expect: () => [
      const EditMealState.loading(),
      const EditMealState.loadError(NotFoundException('Meal not found')),
    ],
  );

  blocTest<EditMealBloc, EditMealState>(
    'submitPressed on a valid loaded form emits [submitting, success]',
    setUp: () {
      when(() => updateMeal('meal-1', any(), isStopped: any(named: 'isStopped')))
          .thenAnswer((_) async => const Result.success(existingMeal));
    },
    build: () => EditMealBloc(getMeal, updateMeal),
    seed: () => EditMealState.form(validFormData),
    act: (bloc) => bloc.add(const EditMealEvent.submitPressed()),
    expect: () => [
      EditMealState.form(
        validFormData.copyWith(submitStatus: const MealSubmitStatus.submitting()),
      ),
      EditMealState.form(
        validFormData.copyWith(submitStatus: const MealSubmitStatus.success(existingMeal)),
      ),
    ],
  );

  blocTest<EditMealBloc, EditMealState>(
    'submitPressed with an empty name emits validationFailure and never calls updateMeal',
    build: () => EditMealBloc(getMeal, updateMeal),
    seed: () => EditMealState.form(validFormData.copyWith(name: '')),
    act: (bloc) => bloc.add(const EditMealEvent.submitPressed()),
    expect: () => [
      isA<EditMealState>().having(
        (s) => (s as EditMealForm).data.submitStatus,
        'submitStatus',
        isA<MealSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => updateMeal(any(), any(), isStopped: any(named: 'isStopped'))),
  );
}
