import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/offer_meal_draft.dart';
import '../../../shared/presentation/bloc/offer_submit_status.dart';

part 'edit_offer_state.freezed.dart';

/// Two independent sources of UI-distinct branching justify Bloc here:
/// the load phase (`loading`/`loadError`/`form`) and CK-13's E1–E3
/// submit exceptions once the form is loaded — mirrors `EditMealState`.
@freezed
class EditOfferState with _$EditOfferState {
  const factory EditOfferState.loading() = EditOfferLoading;
  const factory EditOfferState.loadError(AppException exception) = EditOfferLoadError;
  const factory EditOfferState.form(EditOfferFormData data) = EditOfferForm;
}

@freezed
class EditOfferFormData with _$EditOfferFormData {
  const factory EditOfferFormData({
    required String offerId,
    @Default('') String name,
    @Default('') String description,
    @Default('') String totalPriceInput,
    @Default('') String durationDaysInput,
    @Default(true) bool isActive,
    String? imagePath,
    int? imageSizeBytes,
    @Default(<OfferMealDraft>[]) List<OfferMealDraft> includedMeals,
    @Default(OfferSubmitStatus.idle()) OfferSubmitStatus submitStatus,
  }) = _EditOfferFormData;
}
