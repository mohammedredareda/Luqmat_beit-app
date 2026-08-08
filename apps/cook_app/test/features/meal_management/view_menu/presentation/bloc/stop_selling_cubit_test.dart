import '../../../../../support/bloc_test_helper.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:cook_app/features/meal_management/view_menu/domain/usecases/set_selling_paused.dart';
import 'package:cook_app/features/meal_management/view_menu/presentation/bloc/stop_selling_cubit.dart';
import 'package:cook_app/features/meal_management/view_menu/presentation/bloc/stop_selling_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSetSellingPaused extends Mock implements SetSellingPaused {}

void main() {
  late _MockSetSellingPaused setSellingPaused;

  setUp(() {
    setSellingPaused = _MockSetSellingPaused();
  });

  blocTest<StopSellingCubit, StopSellingState>(
    'confirm to pause emits [submitting, success(true)]',
    setUp: () {
      when(() => setSellingPaused(cookId: currentCookId, isPaused: true))
          .thenAnswer((_) async => const Result.success(true));
    },
    build: () => StopSellingCubit(setSellingPaused),
    act: (cubit) => cubit.setPaused(true),
    expect: () => [
      const StopSellingState.submitting(),
      const StopSellingState.success(true),
    ],
  );

  blocTest<StopSellingCubit, StopSellingState>(
    'confirm to resume emits [submitting, failure] when the repository call fails',
    setUp: () {
      when(() => setSellingPaused(cookId: currentCookId, isPaused: false)).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => StopSellingCubit(setSellingPaused),
    act: (cubit) => cubit.setPaused(false),
    expect: () => [
      const StopSellingState.submitting(),
      const StopSellingState.failure(ServerErrorException('backend unreachable')),
    ],
  );
}
