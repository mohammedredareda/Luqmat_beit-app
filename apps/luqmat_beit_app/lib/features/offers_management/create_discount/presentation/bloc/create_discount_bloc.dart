import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/discount_form_validator.dart';
import '../../../shared/domain/discount_restriction_type.dart';
import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../domain/usecases/create_discount.dart';
import 'create_discount_event.dart';
import 'create_discount_state.dart';

/// CK-12 Create Discount — E1 percentage out of range, E2 meal required,
/// missing duration are UI-distinct exception flows.
class CreateDiscountBloc extends Bloc<CreateDiscountEvent, CreateDiscountState> {
  CreateDiscountBloc(this._createDiscount) : super(const CreateDiscountState()) {
    on<CreateDiscountEvent>((event, emit) => event.when(
          mealSelected: (meal) async => emit(state.copyWith(selectedMeal: meal)),
          percentageChanged: (value) async => emit(state.copyWith(percentageInput: value)),
          restrictionTypeChanged: (type) async => emit(state.copyWith(restrictionType: type)),
          durationDaysChanged: (value) async => emit(state.copyWith(durationDaysInput: value)),
          usageLimitChanged: (value) async => emit(state.copyWith(usageLimitInput: value)),
          submitPressed: () => _submit(emit),
        ));
  }

  final CreateDiscount _createDiscount;

  /// `DiscountFormSubmission.discountDurationDays` is non-nullable, so a
  /// ~1-year placeholder stands in when the cook picked usage-count mode
  /// instead of leaving it unset — this value never reaches the API as a
  /// real duration (see that field's doc comment: duration and usage-count
  /// are mutually exclusive on the wire, confirmed live).
  static const _usageOnlyDurationDaysFallback = 365;

  Future<void> _submit(Emitter<CreateDiscountState> emit) async {
    final errors = validateDiscountForm(
      mealId: state.selectedMeal?.id,
      percentageInput: state.percentageInput,
      durationDaysInput: state.durationDaysInput,
      usageLimitInput: state.usageLimitInput,
      restrictionType: state.restrictionType,
    );

    if (errors.isNotEmpty) {
      emit(state.copyWith(submitStatus: DiscountSubmitStatus.validationFailure(errors)));
      return;
    }

    emit(state.copyWith(submitStatus: const DiscountSubmitStatus.submitting()));

    final meal = state.selectedMeal!;
    final isUsageCountMode = state.restrictionType == DiscountRestrictionType.usageCount;
    final submission = DiscountFormSubmission(
      mealId: meal.id,
      mealName: meal.name,
      mealImageUrl: meal.imageUrl,
      mealBasePrice: meal.startingPrice,
      discountPercentage: double.parse(state.percentageInput),
      discountDurationDays:
          isUsageCountMode ? _usageOnlyDurationDaysFallback : int.parse(state.durationDaysInput),
      usageNumberLimit: isUsageCountMode ? int.parse(state.usageLimitInput) : null,
    );

    final result = await _createDiscount(submission);
    result.fold(
      (discount) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.success(discount))),
      (exception) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.failure(exception))),
    );
  }
}
