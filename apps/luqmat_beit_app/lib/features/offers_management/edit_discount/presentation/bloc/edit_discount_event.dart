import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_discount_event.freezed.dart';

/// No `mealSelected` event — a discount's target meal is read-only once
/// it exists (decision 14).
@freezed
class EditDiscountEvent with _$EditDiscountEvent {
  const factory EditDiscountEvent.started(String discountId) = _Started;
  const factory EditDiscountEvent.retryLoadPressed() = _RetryLoadPressed;
  const factory EditDiscountEvent.percentageChanged(String value) = _PercentageChanged;
  const factory EditDiscountEvent.durationDaysChanged(String value) = _DurationDaysChanged;
  const factory EditDiscountEvent.usageLimitChanged(String value) = _UsageLimitChanged;
  const factory EditDiscountEvent.submitPressed() = _SubmitPressed;
}
