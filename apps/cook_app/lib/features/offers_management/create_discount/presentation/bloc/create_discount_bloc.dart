import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/discount_form_validator.dart';
import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../domain/usecases/create_discount.dart';
import 'create_discount_event.dart';
import 'create_discount_state.dart';

/// CK-12 Create Discount — E1 percentage out of range, E2 meal required,
/// E3 restriction-mode field required are 3 UI-distinct exception flows.
@injectable
class CreateDiscountBloc extends Bloc<CreateDiscountEvent, CreateDiscountState> {
  CreateDiscountBloc(this._createDiscount) : super(const CreateDiscountState()) {
    on<CreateDiscountEvent>((event, emit) => event.when(
          mealSelected: (meal) async => emit(state.copyWith(selectedMeal: meal)),
          percentageChanged: (value) async => emit(state.copyWith(percentageInput: value)),
          restrictionModeChanged: (mode) async => emit(state.copyWith(mode: mode)),
          durationDaysChanged: (value) async => emit(state.copyWith(durationDaysInput: value)),
          usageLimitChanged: (value) async => emit(state.copyWith(usageLimitInput: value)),
          submitPressed: () => _submit(emit),
        ));
  }

  final CreateDiscount _createDiscount;

  Future<void> _submit(Emitter<CreateDiscountState> emit) async {
    final errors = validateDiscountForm(
      mealId: state.selectedMeal?.id,
      percentageInput: state.percentageInput,
      mode: state.mode,
      durationDaysInput: state.durationDaysInput,
      usageLimitInput: state.usageLimitInput,
    );

    if (errors.isNotEmpty) {
      emit(state.copyWith(submitStatus: DiscountSubmitStatus.validationFailure(errors)));
      return;
    }

    emit(state.copyWith(submitStatus: const DiscountSubmitStatus.submitting()));

    final meal = state.selectedMeal!;
    final submission = DiscountFormSubmission(
      mealId: meal.id,
      mealName: meal.name,
      mealImageUrl: meal.imageUrl,
      mealBasePrice: meal.displayPrice,
      percentage: double.parse(state.percentageInput),
      mode: state.mode,
      durationDays: state.mode == DiscountRestrictionMode.duration
          ? int.parse(state.durationDaysInput)
          : null,
      usageLimit:
          state.mode == DiscountRestrictionMode.usage ? int.parse(state.usageLimitInput) : null,
    );

    final result = await _createDiscount(submission);
    result.fold(
      (discount) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.success(discount))),
      (exception) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.failure(exception))),
    );
  }
}
