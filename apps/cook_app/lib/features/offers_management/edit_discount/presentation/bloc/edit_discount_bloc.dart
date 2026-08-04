import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/discount_form_validator.dart';
import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../domain/usecases/get_discount.dart';
import '../../domain/usecases/update_discount.dart';
import 'edit_discount_event.dart';
import 'edit_discount_state.dart';

@injectable
class EditDiscountBloc extends Bloc<EditDiscountEvent, EditDiscountState> {
  EditDiscountBloc(this._getDiscount, this._updateDiscount)
      : super(const EditDiscountState.loading()) {
    on<EditDiscountEvent>((event, emit) => event.when(
          started: (discountId) => _load(discountId, emit),
          retryLoadPressed: () async {
            final discountId = _lastDiscountId;
            if (discountId != null) await _load(discountId, emit);
            return null;
          },
          percentageChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(percentageInput: value)),
          restrictionModeChanged: (mode) async =>
              _updateForm(emit, (data) => data.copyWith(mode: mode)),
          durationDaysChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(durationDaysInput: value)),
          usageLimitChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(usageLimitInput: value)),
          submitPressed: () => _submit(emit),
        ));
  }

  final GetDiscount _getDiscount;
  final UpdateDiscount _updateDiscount;
  String? _lastDiscountId;

  void _updateForm(
    Emitter<EditDiscountState> emit,
    EditDiscountFormData Function(EditDiscountFormData data) transform,
  ) {
    final current = state;
    if (current is EditDiscountForm) emit(EditDiscountState.form(transform(current.data)));
  }

  Future<void> _load(String discountId, Emitter<EditDiscountState> emit) async {
    _lastDiscountId = discountId;
    emit(const EditDiscountState.loading());
    final result = await _getDiscount(discountId);
    result.fold(
      (bundle) => emit(EditDiscountState.form(EditDiscountFormData(
        discountId: bundle.discount.id,
        mealId: bundle.discount.mealId,
        mealName: bundle.discount.mealName,
        mealImageUrl: bundle.discount.mealImageUrl,
        mealBasePrice: bundle.mealPrice,
        mealSellingOptions: bundle.mealSellingOptions,
        percentageInput: bundle.discount.percentage.toString(),
        mode: bundle.discount.mode,
        durationDaysInput: bundle.discount.durationDays?.toString() ?? '',
        usageLimitInput: bundle.discount.usageLimit?.toString() ?? '',
        remainingDaysDisplay: bundle.discount.remainingDays,
        remainingUsageDisplay: bundle.discount.remainingUsage,
      ))),
      (exception) => emit(EditDiscountState.loadError(exception)),
    );
  }

  Future<void> _submit(Emitter<EditDiscountState> emit) async {
    final formState = state;
    if (formState is! EditDiscountForm) return;
    final data = formState.data;

    final errors = validateDiscountForm(
      mealId: data.mealId,
      percentageInput: data.percentageInput,
      mode: data.mode,
      durationDaysInput: data.durationDaysInput,
      usageLimitInput: data.usageLimitInput,
    );

    if (errors.isNotEmpty) {
      emit(EditDiscountState.form(
        data.copyWith(submitStatus: DiscountSubmitStatus.validationFailure(errors)),
      ));
      return;
    }

    emit(EditDiscountState.form(data.copyWith(submitStatus: const DiscountSubmitStatus.submitting())));

    final input = DiscountUpdateInput(
      percentage: double.parse(data.percentageInput),
      mode: data.mode,
      durationDays:
          data.mode == DiscountRestrictionMode.duration ? int.parse(data.durationDaysInput) : null,
      usageLimit:
          data.mode == DiscountRestrictionMode.usage ? int.parse(data.usageLimitInput) : null,
    );

    final result = await _updateDiscount(data.discountId, input);
    result.fold(
      (discount) => emit(
        EditDiscountState.form(data.copyWith(submitStatus: DiscountSubmitStatus.success(discount))),
      ),
      (exception) => emit(
        EditDiscountState.form(data.copyWith(submitStatus: DiscountSubmitStatus.failure(exception))),
      ),
    );
  }
}
