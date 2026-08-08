import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_meal_state.freezed.dart';

@freezed
class SelectMealState with _$SelectMealState {
  const factory SelectMealState.initial() = SelectMealInitial;
  const factory SelectMealState.loading() = SelectMealLoading;
  const factory SelectMealState.loaded(List<MealEntity> meals) = SelectMealLoaded;
  const factory SelectMealState.error(AppException exception) = SelectMealError;
}
