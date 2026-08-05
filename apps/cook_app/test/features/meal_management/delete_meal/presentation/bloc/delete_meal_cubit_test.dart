import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/meal_management/delete_meal/domain/usecases/delete_meal.dart';
import 'package:cook_app/features/meal_management/delete_meal/presentation/bloc/delete_meal_cubit.dart';
import 'package:cook_app/features/meal_management/delete_meal/presentation/bloc/delete_meal_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDeleteMeal extends Mock implements DeleteMeal {}

void main() {
  late _MockDeleteMeal deleteMeal;

  setUp(() {
    deleteMeal = _MockDeleteMeal();
  });

  blocTest<DeleteMealCubit, DeleteMealState>(
    'confirm to delete emits [submitting, success(mealId)]',
    setUp: () {
      when(() => deleteMeal('meal-1')).thenAnswer((_) async => const Result.success(null));
    },
    build: () => DeleteMealCubit(deleteMeal),
    act: (cubit) => cubit.delete('meal-1'),
    expect: () => [
      const DeleteMealState.submitting(),
      const DeleteMealState.success('meal-1'),
    ],
  );

  blocTest<DeleteMealCubit, DeleteMealState>(
    'emits [submitting, failure] when the repository call fails',
    setUp: () {
      when(() => deleteMeal('meal-1')).thenAnswer(
        (_) async => const Result.failure(ServerErrorException('backend unreachable')),
      );
    },
    build: () => DeleteMealCubit(deleteMeal),
    act: (cubit) => cubit.delete('meal-1'),
    expect: () => [
      const DeleteMealState.submitting(),
      const DeleteMealState.failure(ServerErrorException('backend unreachable')),
    ],
  );
}
