import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/offer_meal_draft.dart';
import '../../../shared/presentation/bloc/offer_submit_status.dart';

part 'create_offer_state.freezed.dart';

/// A single data class holding every form field, rather than a sealed
/// union of named variants, mirroring `CreateMealState`'s reasoning.
@freezed
class CreateOfferState with _$CreateOfferState {
  const factory CreateOfferState({
    @Default('') String name,
    @Default('') String description,
    @Default('') String totalPriceInput,
    @Default('') String durationDaysInput,
    @Default(true) bool isActive,
    String? imagePath,
    int? imageSizeBytes,
    @Default(<OfferMealDraft>[]) List<OfferMealDraft> includedMeals,
    @Default(OfferSubmitStatus.idle()) OfferSubmitStatus submitStatus,
  }) = _CreateOfferState;
}
