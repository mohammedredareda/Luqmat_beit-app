import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/shorts_management/create_short/domain/usecases/create_short.dart';
import 'package:luqmat_beit_app/features/shorts_management/create_short/presentation/bloc/create_short_bloc.dart';
import 'package:luqmat_beit_app/features/shorts_management/create_short/presentation/bloc/create_short_event.dart';
import 'package:luqmat_beit_app/features/shorts_management/create_short/presentation/bloc/create_short_state.dart';
import 'package:luqmat_beit_app/features/shorts_management/shared/domain/entities/short_management_entity.dart';
import 'package:luqmat_beit_app/features/shorts_management/shared/domain/short_form_submission.dart';
import 'package:luqmat_beit_app/features/shorts_management/shared/presentation/bloc/short_submit_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCreateShort extends Mock implements CreateShort {}

void main() {
  late _MockCreateShort createShort;

  setUpAll(() {
    registerFallbackValue(const ShortFormSubmission(videoPath: '', description: ''));
  });

  setUp(() {
    createShort = _MockCreateShort();
  });

  const meal = MealEntity(
    id: 'meal-4',
    cookId: 'cook-1',
    cookName: 'Cook One',
    name: 'حمص بالصنوبر',
    description: '',
    imageUrl: 'https://picsum.photos/seed/hummus/200/200',
    sellingOptions: [],
    singlePrice: 15,
  );

  final createdShort = ShortManagementEntity(
    id: 'short-new',
    cookId: 'cook-1',
    description: 'وصف المقطع',
    viewCount: 0,
    createdAt: DateTime(2026),
  );

  blocTest<CreateShortBloc, CreateShortState>(
    'submitPressed with no video picked emits validationFailure',
    build: () => CreateShortBloc(createShort),
    seed: () => const CreateShortState(description: 'وصف المقطع'),
    act: (bloc) => bloc.add(const CreateShortEvent.submitPressed()),
    expect: () => [
      isA<CreateShortState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<ShortSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => createShort(any())),
  );

  blocTest<CreateShortBloc, CreateShortState>(
    'submitPressed with an empty description emits validationFailure',
    build: () => CreateShortBloc(createShort),
    seed: () => const CreateShortState(videoPath: '/tmp/short.mp4', videoSizeBytes: 1000),
    act: (bloc) => bloc.add(const CreateShortEvent.submitPressed()),
    expect: () => [
      isA<CreateShortState>().having(
        (s) => s.submitStatus,
        'submitStatus',
        isA<ShortSubmitValidationFailure>(),
      ),
    ],
  );

  blocTest<CreateShortBloc, CreateShortState>(
    'mealRemoved clears a previously selected meal',
    build: () => CreateShortBloc(createShort),
    seed: () => const CreateShortState(selectedMeal: meal),
    act: (bloc) => bloc.add(const CreateShortEvent.mealRemoved()),
    expect: () => [
      isA<CreateShortState>().having((s) => s.selectedMeal, 'selectedMeal', isNull),
    ],
  );

  blocTest<CreateShortBloc, CreateShortState>(
    'valid submit without a linked meal emits [submitting, success]',
    setUp: () {
      when(() => createShort(any())).thenAnswer((_) async => Result.success(createdShort));
    },
    build: () => CreateShortBloc(createShort),
    seed: () => const CreateShortState(videoPath: '/tmp/short.mp4', description: 'وصف المقطع'),
    act: (bloc) => bloc.add(const CreateShortEvent.submitPressed()),
    expect: () => [
      isA<CreateShortState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<ShortSubmitSubmitting>()),
      isA<CreateShortState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<ShortSubmitSuccess>()),
    ],
  );

  blocTest<CreateShortBloc, CreateShortState>(
    'valid submit with a linked meal emits [submitting, success]',
    setUp: () {
      when(() => createShort(any())).thenAnswer((_) async => Result.success(createdShort));
    },
    build: () => CreateShortBloc(createShort),
    seed: () => const CreateShortState(
      videoPath: '/tmp/short.mp4',
      description: 'وصف المقطع',
      selectedMeal: meal,
    ),
    act: (bloc) => bloc.add(const CreateShortEvent.submitPressed()),
    expect: () => [
      isA<CreateShortState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<ShortSubmitSubmitting>()),
      isA<CreateShortState>()
          .having((s) => s.submitStatus, 'submitStatus', isA<ShortSubmitSuccess>()),
    ],
  );
}
