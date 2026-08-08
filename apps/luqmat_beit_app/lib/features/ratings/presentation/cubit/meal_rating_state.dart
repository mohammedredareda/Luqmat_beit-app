import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_rating_state.freezed.dart';

/// Single fetch-then-submit flow (CU-23) — star + optional review, submit,
/// success — no UI-distinct alternative flows, hence a Cubit, not a Bloc.
@freezed
sealed class MealRatingState with _$MealRatingState {
  const factory MealRatingState.initial() = MealRatingInitial;
  const factory MealRatingState.loading() = MealRatingLoading;
  const factory MealRatingState.loaded({
    required OrderEntity order,
    @Default(0) int stars,
    @Default('') String review,
    @Default(false) bool isSubmitting,
    AppException? submitError,
  }) = MealRatingLoaded;
  const factory MealRatingState.submitted() = MealRatingSubmitted;
  const factory MealRatingState.failure(AppException exception) = MealRatingFailure;
}
