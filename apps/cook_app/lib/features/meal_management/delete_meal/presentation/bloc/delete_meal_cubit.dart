import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/delete_meal.dart';
import 'delete_meal_state.dart';

/// CK-09 Delete Meal. A single linear confirm-then-mutate flow — the
/// confirm/cancel branch lives in the confirmation dialog's own return
/// value (awaited before this is ever invoked), same Cubit-over-Bloc
/// reasoning as `StopSellingCubit`.
@injectable
class DeleteMealCubit extends Cubit<DeleteMealState> {
  DeleteMealCubit(this._deleteMeal) : super(const DeleteMealState.initial());

  final DeleteMeal _deleteMeal;

  Future<void> delete(String mealId) async {
    emit(const DeleteMealState.submitting());
    final result = await _deleteMeal(mealId);
    result.fold(
      (_) => emit(DeleteMealState.success(mealId)),
      (exception) => emit(DeleteMealState.failure(exception)),
    );
  }
}
