import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_selectable_meals.dart';
import 'select_meal_state.dart';

/// Backs the Select Meal popup's grid — a single fetch-and-display flow,
/// matching `ViewMenuCubit`.
class SelectMealCubit extends Cubit<SelectMealState> {
  SelectMealCubit(this._getSelectableMeals) : super(const SelectMealState.initial());

  final GetSelectableMeals _getSelectableMeals;

  Future<void> load() async {
    emit(const SelectMealState.loading());
    final result = await _getSelectableMeals(currentCookId);
    result.fold(
      (meals) => emit(SelectMealState.loaded(meals)),
      (exception) => emit(SelectMealState.error(exception)),
    );
  }
}
