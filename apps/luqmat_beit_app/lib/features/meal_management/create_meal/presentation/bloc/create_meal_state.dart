import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/bloc/meal_variation_draft.dart';

part 'create_meal_state.freezed.dart';

/// A single data class holding every form field, rather than a sealed
/// union of named variants — a literal union would force duplicating all
/// ~9 fields across every state variant just so the UI keeps showing what
/// the cook typed while an error is displayed. The one place a real
/// sealed union is warranted — the submit outcome — is the nested
/// [MealSubmitStatus], which mirrors `StopSellingState`'s shape.
@freezed
class CreateMealState with _$CreateMealState {
  const factory CreateMealState({
    @Default('') String name,
    @Default('') String description,
    @Default(<String>{}) Set<String> categoryIds,
    @Default('') String preorderHoursInput,
    @Default(false) bool sellWithVariations,
    @Default('') String priceInput,
    @Default(<MealVariationDraft>[]) List<MealVariationDraft> variations,
    String? imagePath,
    int? imageSizeBytes,
    @Default(MealSubmitStatus.idle()) MealSubmitStatus submitStatus,
  }) = _CreateMealState;
}
