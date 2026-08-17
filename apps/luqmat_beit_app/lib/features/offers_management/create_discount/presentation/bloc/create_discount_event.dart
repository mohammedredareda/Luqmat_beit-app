import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/discount_restriction_type.dart';

part 'create_discount_event.freezed.dart';

@freezed
class CreateDiscountEvent with _$CreateDiscountEvent {
  const factory CreateDiscountEvent.mealSelected(MealEntity meal) = _MealSelected;
  const factory CreateDiscountEvent.percentageChanged(String value) = _PercentageChanged;
  const factory CreateDiscountEvent.restrictionTypeChanged(DiscountRestrictionType type) =
      _RestrictionTypeChanged;
  const factory CreateDiscountEvent.durationDaysChanged(String value) = _DurationDaysChanged;
  const factory CreateDiscountEvent.usageLimitChanged(String value) = _UsageLimitChanged;
  const factory CreateDiscountEvent.submitPressed() = _SubmitPressed;
}
