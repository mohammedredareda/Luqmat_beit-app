import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_submit_status.freezed.dart';

/// The submit outcome sub-state shared by `CreateMealState` and
/// `EditMealFormData` — the one place in the create/edit form state that
/// is a real sealed union of named variants (the surrounding form state
/// stays a single data class so the UI can keep showing what the cook
/// typed across every outcome, see `create_meal_state.dart`'s doc).
@freezed
class MealSubmitStatus with _$MealSubmitStatus {
  const factory MealSubmitStatus.idle() = MealSubmitIdle;
  const factory MealSubmitStatus.submitting() = MealSubmitSubmitting;
  const factory MealSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = MealSubmitValidationFailure;
  const factory MealSubmitStatus.success(MealEntity meal) = MealSubmitSuccess;
  const factory MealSubmitStatus.failure(AppException exception) = MealSubmitFailure;
}
