import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../../../shared/domain/discount_form_validator.dart';
import '../../../shared/domain/discount_restriction_type.dart';
import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../domain/usecases/get_discount.dart';
import '../../domain/usecases/update_discount.dart';
import 'edit_discount_event.dart';
import 'edit_discount_state.dart';

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
          restrictionTypeChanged: (type) async =>
              _updateForm(emit, (data) => data.copyWith(restrictionType: type)),
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

  /// The wire contract requires a duration on every request even when the
  /// cook picked usage-count mode — mirrors `CreateDiscountBloc`'s fallback.
  static const _usageOnlyDurationDaysFallback = 365;

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
      (bundle) {
        final discount = bundle.discount;
        final remainingDays = discount.expiryTime.difference(DateTime.now()).inDays;
        final remainingUsage = discount.usageNumberLimit == null
            ? null
            : discount.usageNumberLimit! - discount.usageCount;
        emit(EditDiscountState.form(EditDiscountFormData(
          discountId: discount.id,
          mealId: discount.mealId,
          mealName: bundle.mealName,
          mealImageUrl: bundle.mealImageUrl,
          mealBasePrice: bundle.mealPrice,
          mealSellingOptions: bundle.mealSellingOptions,
          percentageInput: discount.discountPercentage.toString(),
          // An existing discount predates the duration/usage-count toggle
          // being mutually exclusive, so infer which one is actually
          // constraining it: usage-count if it has a limit set, else
          // duration (every discount always carries a duration).
          restrictionType: discount.usageNumberLimit != null
              ? DiscountRestrictionType.usageCount
              : DiscountRestrictionType.duration,
          durationDaysInput: discount.discountDurationDays.toString(),
          usageLimitInput: discount.usageNumberLimit?.toString() ?? '',
          remainingDaysDisplay: remainingDays,
          remainingUsageDisplay: remainingUsage,
        )));
      },
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
      durationDaysInput: data.durationDaysInput,
      usageLimitInput: data.usageLimitInput,
      restrictionType: data.restrictionType,
    );

    if (errors.isNotEmpty) {
      emit(EditDiscountState.form(
        data.copyWith(submitStatus: DiscountSubmitStatus.validationFailure(errors)),
      ));
      return;
    }

    emit(EditDiscountState.form(data.copyWith(submitStatus: const DiscountSubmitStatus.submitting())));

    final isUsageCountMode = data.restrictionType == DiscountRestrictionType.usageCount;
    final input = DiscountUpdateInput(
      discountPercentage: double.parse(data.percentageInput),
      discountDurationDays:
          isUsageCountMode ? _usageOnlyDurationDaysFallback : int.parse(data.durationDaysInput),
      usageNumberLimit: isUsageCountMode ? int.parse(data.usageLimitInput) : null,
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
