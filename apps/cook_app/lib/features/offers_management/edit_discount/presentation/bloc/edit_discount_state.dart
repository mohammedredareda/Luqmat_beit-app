import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/discount_submit_status.dart';

part 'edit_discount_state.freezed.dart';

@freezed
class EditDiscountState with _$EditDiscountState {
  const factory EditDiscountState.loading() = EditDiscountLoading;
  const factory EditDiscountState.loadError(AppException exception) = EditDiscountLoadError;
  const factory EditDiscountState.form(EditDiscountFormData data) = EditDiscountForm;
}

@freezed
class EditDiscountFormData with _$EditDiscountFormData {
  const factory EditDiscountFormData({
    required String discountId,
    required String mealId,
    required String mealName,
    required String mealImageUrl,
    required double mealBasePrice,
    @Default(<SellingOptionEntity>[]) List<SellingOptionEntity> mealSellingOptions,
    @Default('') String percentageInput,
    @Default(DiscountRestrictionMode.duration) DiscountRestrictionMode mode,
    @Default('') String durationDaysInput,
    @Default('') String usageLimitInput,
    int? remainingDaysDisplay,
    int? remainingUsageDisplay,
    @Default(DiscountSubmitStatus.idle()) DiscountSubmitStatus submitStatus,
  }) = _EditDiscountFormData;
}
