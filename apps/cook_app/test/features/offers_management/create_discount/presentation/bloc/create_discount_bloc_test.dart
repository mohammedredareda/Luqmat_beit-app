import '../../../../../support/bloc_test_helper.dart';
import 'package:cook_app/features/offers_management/create_discount/domain/usecases/create_discount.dart';
import 'package:cook_app/features/offers_management/create_discount/presentation/bloc/create_discount_bloc.dart';
import 'package:cook_app/features/offers_management/create_discount/presentation/bloc/create_discount_event.dart';
import 'package:cook_app/features/offers_management/create_discount/presentation/bloc/create_discount_state.dart';
import 'package:cook_app/features/offers_management/shared/domain/discount_form_submission.dart';
import 'package:cook_app/features/offers_management/shared/presentation/bloc/discount_submit_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCreateDiscount extends Mock implements CreateDiscount {}

void main() {
  late _MockCreateDiscount createDiscount;

  setUpAll(() {
    registerFallbackValue(const DiscountFormSubmission(
      mealId: '',
      mealName: '',
      mealImageUrl: '',
      mealBasePrice: 0,
      discountPercentage: 0,
      discountDurationDays: 1,
    ));
  });

  setUp(() {
    createDiscount = _MockCreateDiscount();
  });

  const meal = MealEntity(
    id: 'meal-4',
    cookId: 'cook-1',
    cookName: 'Cook One',
    name: 'مسقعة باذنجان',
    description: '',
    imageUrl: 'https://picsum.photos/seed/moussaka/200/200',
    sellingOptions: [],
    singlePrice: 25,
  );

  final createdDiscount = DiscountEntity(
    id: 'discount-new',
    mealId: 'meal-4',
    discountPercentage: 25,
    discountDurationDays: 7,
    createdAt: DateTime(2026),
    expiryTime: DateTime(2026, 1, 8),
  );

  blocTest<CreateDiscountBloc, CreateDiscountState>(
    'submitPressed with no meal selected emits validationFailure',
    build: () => CreateDiscountBloc(createDiscount),
    seed: () => const CreateDiscountState(percentageInput: '20', durationDaysInput: '5'),
    act: (bloc) => bloc.add(const CreateDiscountEvent.submitPressed()),
    expect: () => [
      isA<CreateDiscountState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<DiscountSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => createDiscount(any())),
  );

  blocTest<CreateDiscountBloc, CreateDiscountState>(
    'submitPressed with percentage 101 emits validationFailure',
    build: () => CreateDiscountBloc(createDiscount),
    seed: () => const CreateDiscountState(
      selectedMeal: meal,
      percentageInput: '101',
      durationDaysInput: '5',
    ),
    act: (bloc) => bloc.add(const CreateDiscountEvent.submitPressed()),
    expect: () => [
      isA<CreateDiscountState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<DiscountSubmitValidationFailure>(),
      ),
    ],
  );

  blocTest<CreateDiscountBloc, CreateDiscountState>(
    'submitPressed with empty days emits validationFailure',
    build: () => CreateDiscountBloc(createDiscount),
    seed: () => const CreateDiscountState(selectedMeal: meal, percentageInput: '20'),
    act: (bloc) => bloc.add(const CreateDiscountEvent.submitPressed()),
    expect: () => [
      isA<CreateDiscountState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<DiscountSubmitValidationFailure>(),
      ),
    ],
  );

  blocTest<CreateDiscountBloc, CreateDiscountState>(
    'valid submit with only duration emits [submitting, success]',
    setUp: () {
      when(() => createDiscount(any())).thenAnswer((_) async => Result.success(createdDiscount));
    },
    build: () => CreateDiscountBloc(createDiscount),
    seed: () => const CreateDiscountState(
      selectedMeal: meal,
      percentageInput: '25',
      durationDaysInput: '7',
    ),
    act: (bloc) => bloc.add(const CreateDiscountEvent.submitPressed()),
    expect: () => [
      isA<CreateDiscountState>().having(
          (s) => s.submitStatus, 'submitStatus', isA<DiscountSubmitSubmitting>()),
      isA<CreateDiscountState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<DiscountSubmitSuccess>()),
    ],
  );

  blocTest<CreateDiscountBloc, CreateDiscountState>(
    'valid submit with duration and usage limit emits [submitting, success]',
    setUp: () {
      when(() => createDiscount(any())).thenAnswer((_) async => Result.success(createdDiscount));
    },
    build: () => CreateDiscountBloc(createDiscount),
    seed: () => const CreateDiscountState(
      selectedMeal: meal,
      percentageInput: '25',
      durationDaysInput: '7',
      usageLimitInput: '20',
    ),
    act: (bloc) => bloc.add(const CreateDiscountEvent.submitPressed()),
    expect: () => [
      isA<CreateDiscountState>().having(
          (s) => s.submitStatus, 'submitStatus', isA<DiscountSubmitSubmitting>()),
      isA<CreateDiscountState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<DiscountSubmitSuccess>()),
    ],
  );
}
