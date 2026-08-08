import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_variation_draft.freezed.dart';

/// One in-progress "sell with variations" row in the create/edit form —
/// [priceInput] stays a raw string (mirrors what the TextField holds)
/// until validation/submission parses it.
@freezed
class MealVariationDraft with _$MealVariationDraft {
  const factory MealVariationDraft({
    required String localId,
    @Default('') String label,
    @Default('') String priceInput,
  }) = _MealVariationDraft;
}
