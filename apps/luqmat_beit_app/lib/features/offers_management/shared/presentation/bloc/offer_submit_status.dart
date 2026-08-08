import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_submit_status.freezed.dart';

/// The submit outcome sub-state shared by `CreateOfferState` and
/// `EditOfferFormData`, mirroring `MealSubmitStatus`'s shape.
@freezed
class OfferSubmitStatus with _$OfferSubmitStatus {
  const factory OfferSubmitStatus.idle() = OfferSubmitIdle;
  const factory OfferSubmitStatus.submitting() = OfferSubmitSubmitting;
  const factory OfferSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = OfferSubmitValidationFailure;
  const factory OfferSubmitStatus.success(OfferEntity offer) = OfferSubmitSuccess;
  const factory OfferSubmitStatus.failure(AppException exception) = OfferSubmitFailure;
}
