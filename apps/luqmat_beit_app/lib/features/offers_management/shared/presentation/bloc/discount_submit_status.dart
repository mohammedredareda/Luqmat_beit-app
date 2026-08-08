import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_submit_status.freezed.dart';

/// The submit outcome sub-state shared by `CreateDiscountState` and
/// `EditDiscountFormData`, mirroring `MealSubmitStatus`'s shape.
@freezed
class DiscountSubmitStatus with _$DiscountSubmitStatus {
  const factory DiscountSubmitStatus.idle() = DiscountSubmitIdle;
  const factory DiscountSubmitStatus.submitting() = DiscountSubmitSubmitting;
  const factory DiscountSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = DiscountSubmitValidationFailure;
  const factory DiscountSubmitStatus.success(DiscountEntity discount) = DiscountSubmitSuccess;
  const factory DiscountSubmitStatus.failure(AppException exception) = DiscountSubmitFailure;
}
