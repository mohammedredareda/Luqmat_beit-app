import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_meal_state.freezed.dart';

@freezed
class DeleteMealState with _$DeleteMealState {
  const factory DeleteMealState.initial() = DeleteMealInitial;
  const factory DeleteMealState.submitting() = DeleteMealSubmitting;
  const factory DeleteMealState.success(String mealId) = DeleteMealSuccess;
  const factory DeleteMealState.failure(AppException exception) = DeleteMealFailure;
}
