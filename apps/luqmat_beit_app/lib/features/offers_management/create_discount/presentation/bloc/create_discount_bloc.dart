import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/discount_form_validator.dart';
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
      mealBasePrice: meal.startingPrice,
      discountPercentage: double.parse(state.percentageInput),
      discountDurationDays: int.parse(state.durationDaysInput),
      usageNumberLimit:
          state.usageLimitInput.trim().isEmpty ? null : int.parse(state.usageLimitInput),
    );

    final result = await _createDiscount(submission);
    result.fold(
      (discount) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.success(discount))),
      (exception) => emit(state.copyWith(submitStatus: DiscountSubmitStatus.failure(exception))),
    );
  }
}
