import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_meal_draft.freezed.dart';

/// One in-progress "included meal" row in the create/edit offer form.
@freezed
class OfferMealDraft with _$OfferMealDraft {
  const factory OfferMealDraft({
    required String mealId,
    required String mealName,
    required String mealImageUrl,
    required double unitPrice,
    required int quantity,
    String? sellingOptionId,
    String? sellingOptionLabel,
  }) = _OfferMealDraft;
}
