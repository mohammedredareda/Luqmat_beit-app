import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/domain/offer_form_submission.dart';
import '../../../shared/domain/offer_form_validator.dart';
import '../../../shared/presentation/bloc/offer_meal_draft.dart';
import '../../../shared/presentation/bloc/offer_submit_status.dart';
import '../../domain/usecases/get_offer.dart';
import '../../domain/usecases/update_offer.dart';
import 'edit_offer_event.dart';
import 'edit_offer_state.dart';

@injectable
class EditOfferBloc extends Bloc<EditOfferEvent, EditOfferState> {
  EditOfferBloc(this._getOffer, this._updateOffer) : super(const EditOfferState.loading()) {
    on<EditOfferEvent>((event, emit) => event.when(
          started: (offerId) => _load(offerId, emit),
          retryLoadPressed: () async {
            final offerId = _lastOfferId;
            if (offerId != null) await _load(offerId, emit);
            return null;
          },
          nameChanged: (value) async => _updateForm(emit, (data) => data.copyWith(name: value)),
          descriptionChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(description: value)),
          imagePicked: (path, sizeBytes) async => _updateForm(
                emit,
                (data) => data.copyWith(imagePath: path, imageSizeBytes: sizeBytes),
              ),
          totalPriceChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(totalPriceInput: value)),
          durationDaysChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(durationDaysInput: value)),
          activeToggled: (isActive) async =>
              _updateForm(emit, (data) => data.copyWith(isActive: isActive)),
          mealAdded: (meal, sellingOption) async {
            final current = state;
            if (current is! EditOfferForm) return null;
            if (current.data.includedMeals.any((m) => m.mealId == meal.id)) return null;
            _updateForm(
              emit,
              (data) => data.copyWith(includedMeals: [
                ...data.includedMeals,
                OfferMealDraft(
                  mealId: meal.id,
                  mealName: meal.name,
                  mealImageUrl: meal.imageUrl,
                  sellingOptionId: sellingOption?.id,
                  sellingOptionLabel: sellingOption?.label,
                  unitPrice: sellingOption?.price ?? meal.displayPrice,
                  quantity: 1,
                ),
              ]),
            );
            return null;
          },
          mealRemoved: (mealId) async => _updateForm(
                emit,
                (data) => data.copyWith(
                  includedMeals: data.includedMeals.where((m) => m.mealId != mealId).toList(),
                ),
              ),
          mealQuantityIncremented: (mealId) async => _updateForm(
                emit,
                (data) => data.copyWith(includedMeals: [
                  for (final m in data.includedMeals)
                    if (m.mealId == mealId) m.copyWith(quantity: m.quantity + 1) else m,
                ]),
              ),
          mealQuantityDecremented: (mealId) async => _updateForm(
                emit,
                (data) => data.copyWith(includedMeals: [
                  for (final m in data.includedMeals)
                    if (m.mealId == mealId)
                      m.copyWith(quantity: m.quantity > 1 ? m.quantity - 1 : 1)
                    else
                      m,
                ]),
              ),
          mealSellingOptionChanged: (mealId, option) async => _updateForm(
                emit,
                (data) => data.copyWith(includedMeals: [
                  for (final m in data.includedMeals)
                    if (m.mealId == mealId)
                      m.copyWith(
                        sellingOptionId: option.id,
                        sellingOptionLabel: option.label,
                        unitPrice: option.price,
                      )
                    else
                      m,
                ]),
              ),
          submitPressed: () => _submit(emit),
        ));
  }

  final GetOffer _getOffer;
  final UpdateOffer _updateOffer;
  String? _lastOfferId;

  void _updateForm(
    Emitter<EditOfferState> emit,
    EditOfferFormData Function(EditOfferFormData data) transform,
  ) {
    final current = state;
    if (current is EditOfferForm) emit(EditOfferState.form(transform(current.data)));
  }

  Future<void> _load(String offerId, Emitter<EditOfferState> emit) async {
    _lastOfferId = offerId;
    emit(const EditOfferState.loading());
    final result = await _getOffer(offerId);
    result.fold(
      (offer) => emit(EditOfferState.form(EditOfferFormData(
        offerId: offer.id,
        name: offer.name,
        description: offer.description,
        totalPriceInput: offer.totalPrice.toString(),
        durationDaysInput: offer.durationDays.toString(),
        isActive: offer.isActive,
        imagePath: offer.imageUrl,
        includedMeals: [
          for (final meal in offer.includedMeals)
            OfferMealDraft(
              mealId: meal.mealId,
              mealName: meal.mealName,
              mealImageUrl: meal.mealImageUrl,
              sellingOptionId: meal.sellingOptionId,
              sellingOptionLabel: meal.sellingOptionLabel,
              unitPrice: meal.unitPrice,
              quantity: meal.quantity,
            ),
        ],
      ))),
      (exception) => emit(EditOfferState.loadError(exception)),
    );
  }

  Future<void> _submit(Emitter<EditOfferState> emit) async {
    final formState = state;
    if (formState is! EditOfferForm) return;
    final data = formState.data;

    final errors = validateOfferForm(
      name: data.name,
      totalPriceInput: data.totalPriceInput,
      durationDaysInput: data.durationDaysInput,
      includedMealIds: [for (final m in data.includedMeals) m.mealId],
      imageSizeBytes: data.imageSizeBytes,
    );

    if (errors.isNotEmpty) {
      emit(EditOfferState.form(data.copyWith(submitStatus: OfferSubmitStatus.validationFailure(errors))));
      return;
    }

    emit(EditOfferState.form(data.copyWith(submitStatus: const OfferSubmitStatus.submitting())));

    final submission = OfferFormSubmission(
      name: data.name,
      description: data.description,
      totalPrice: double.parse(data.totalPriceInput),
      durationDays: int.parse(data.durationDaysInput),
      isActive: data.isActive,
      imagePath: data.imagePath,
      includedMeals: [
        for (final m in data.includedMeals)
          OfferMealInput(
            mealId: m.mealId,
            mealName: m.mealName,
            mealImageUrl: m.mealImageUrl,
            sellingOptionId: m.sellingOptionId,
            sellingOptionLabel: m.sellingOptionLabel,
            unitPrice: m.unitPrice,
            quantity: m.quantity,
          ),
      ],
    );

    final result = await _updateOffer(data.offerId, submission);
    result.fold(
      (offer) => emit(EditOfferState.form(data.copyWith(submitStatus: OfferSubmitStatus.success(offer)))),
      (exception) =>
          emit(EditOfferState.form(data.copyWith(submitStatus: OfferSubmitStatus.failure(exception)))),
    );
  }
}
