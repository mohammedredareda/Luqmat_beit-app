import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/meal_management/create_meal/domain/usecases/create_meal.dart';
import 'package:luqmat_beit_app/features/meal_management/create_meal/presentation/bloc/create_meal_bloc.dart';
import 'package:luqmat_beit_app/features/meal_management/create_meal/presentation/bloc/create_meal_event.dart';
import 'package:luqmat_beit_app/features/meal_management/create_meal/presentation/bloc/create_meal_state.dart';
import 'package:luqmat_beit_app/features/meal_management/domain/meal_form_submission.dart';
import 'package:luqmat_beit_app/features/meal_management/shared/presentation/bloc/meal_submit_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCreateMeal extends Mock implements CreateMeal {}

void main() {
  late _MockCreateMeal createMeal;

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
    createMeal = _MockCreateMeal();
  });

  const validState = CreateMealState(
    name: 'فتوش',
    description: 'سلطة خضار مقرمشة',
    preorderHoursInput: '2',
    priceInput: '18',
    imagePath: '/tmp/fattoush.png',
    imageSizeBytes: 1024,
  );

  const createdMeal = MealEntity(
    id: 'meal-new',
    cookId: 'cook-1',
    cookName: 'مطبخ أم أحمد',
    name: 'فتوش',
    description: 'سلطة خضار مقرمشة',
    imageUrl: '/tmp/fattoush.png',
    sellingOptions: [],
    singlePrice: 18,
  );

  blocTest<CreateMealBloc, CreateMealState>(
    'submitPressed with an empty name emits validationFailure and never calls the usecase',
    build: () => CreateMealBloc(createMeal),
    act: (bloc) => bloc.add(const CreateMealEvent.submitPressed()),
    expect: () => [
      isA<CreateMealState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<MealSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => createMeal(any())),
  );

  blocTest<CreateMealBloc, CreateMealState>(
    'submitPressed with a fully valid form emits [submitting, success]',
    setUp: () {
      when(() => createMeal(any())).thenAnswer((_) async => const Result.success(createdMeal));
    },
    build: () => CreateMealBloc(createMeal),
    seed: () => validState,
    act: (bloc) => bloc.add(const CreateMealEvent.submitPressed()),
    expect: () => [
      validState.copyWith(submitStatus: const MealSubmitStatus.submitting()),
      validState.copyWith(submitStatus: const MealSubmitStatus.success(createdMeal)),
    ],
  );

  blocTest<CreateMealBloc, CreateMealState>(
    'submitPressed emits [submitting, failure] when the usecase fails',
    setUp: () {
      when(() => createMeal(any())).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => CreateMealBloc(createMeal),
    seed: () => validState,
    act: (bloc) => bloc.add(const CreateMealEvent.submitPressed()),
    expect: () => [
      validState.copyWith(submitStatus: const MealSubmitStatus.submitting()),
      validState.copyWith(
        submitStatus: const MealSubmitStatus.failure(ServerErrorException('backend unreachable')),
      ),
    ],
  );
}
