import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/bloc/meal_variation_draft.dart';

part 'edit_meal_state.freezed.dart';

/// Two independent sources of UI-distinct branching justify Bloc here:
/// the load phase (`loading`/`loadError` with its own retry affordance/
/// `form`) and CK-07's E1–E4 submit exceptions once the form is loaded.
@freezed
class EditMealState with _$EditMealState {
  const factory EditMealState.loading() = EditMealLoading;
  const factory EditMealState.loadError(AppException exception) = EditMealLoadError;
  const factory EditMealState.form(EditMealFormData data) = EditMealForm;
}

@freezed
class EditMealFormData with _$EditMealFormData {
  const factory EditMealFormData({
    required String mealId,
    @Default('') String name,
    @Default('') String description,
    @Default(<String>{}) Set<String> categoryIds,
    @Default('') String preorderHoursInput,
    @Default(false) bool sellWithVariations,
    @Default('') String priceInput,
    @Default(<MealVariationDraft>[]) List<MealVariationDraft> variations,
    String? imagePath,
    int? imageSizeBytes,
    @Default(true) bool isAvailable,
    @Default(MealSubmitStatus.idle()) MealSubmitStatus submitStatus,
  }) = _EditMealFormData;
}
