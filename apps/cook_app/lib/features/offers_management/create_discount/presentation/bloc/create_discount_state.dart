import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/discount_submit_status.dart';

part 'create_discount_state.freezed.dart';

@freezed
class CreateDiscountState with _$CreateDiscountState {
  const factory CreateDiscountState({
    MealEntity? selectedMeal,
    @Default('') String percentageInput,
    @Default('') String durationDaysInput,
    @Default('') String usageLimitInput,
    @Default(DiscountSubmitStatus.idle()) DiscountSubmitStatus submitStatus,
  }) = _CreateDiscountState;
}
