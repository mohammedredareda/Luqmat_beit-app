import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/offer_form_submission.dart';
import '../../../shared/domain/offer_form_validator.dart';
import '../../../shared/presentation/bloc/offer_meal_draft.dart';
import '../../../shared/presentation/bloc/offer_submit_status.dart';
import '../../domain/usecases/create_offer.dart';
import 'create_offer_event.dart';
import 'create_offer_state.dart';

/// CK-13 Create Offer — E1 zero meals, E2 non-positive price, required
/// duration are 3 UI-distinct exception flows, which is exactly the
/// architecture doc's ">1 UI-distinct exception flow → Bloc" criterion.
class CreateOfferBloc extends Bloc<CreateOfferEvent, CreateOfferState> {
  CreateOfferBloc(this._createOffer) : super(const CreateOfferState()) {
    on<CreateOfferEvent>((event, emit) => event.when(
          nameChanged: (value) async => emit(state.copyWith(name: value)),
          descriptionChanged: (value) async => emit(state.copyWith(description: value)),
          imagePicked: (path, sizeBytes) async =>
              emit(state.copyWith(imagePath: path, imageSizeBytes: sizeBytes)),
          totalPriceChanged: (value) async => emit(state.copyWith(totalPriceInput: value)),
          durationDaysChanged: (value) async => emit(state.copyWith(durationDaysInput: value)),
          activeToggled: (isActive) async => emit(state.copyWith(isActive: isActive)),
          mealAdded: (meal, sellingOption) async {
            if (state.includedMeals.any((m) => m.mealId == meal.id)) return null;
            emit(state.copyWith(includedMeals: [
              ...state.includedMeals,
              OfferMealDraft(
                mealId: meal.id,
                mealName: meal.name,
                mealImageUrl: meal.imageUrl,
                sellingOptionId: sellingOption?.id,
                sellingOptionLabel: sellingOption?.label,
                unitPrice: sellingOption?.price ?? meal.startingPrice,
                quantity: 1,
              ),
            ]));
            return null;
          },
          mealRemoved: (mealId) async => emit(state.copyWith(
                includedMeals: state.includedMeals.where((m) => m.mealId != mealId).toList(),
              )),
          mealQuantityIncremented: (mealId) async => emit(state.copyWith(includedMeals: [
                for (final m in state.includedMeals)
                  if (m.mealId == mealId) m.copyWith(quantity: m.quantity + 1) else m,
              ])),
          mealQuantityDecremented: (mealId) async => emit(state.copyWith(includedMeals: [
                for (final m in state.includedMeals)
                  if (m.mealId == mealId)
                    m.copyWith(quantity: m.quantity > 1 ? m.quantity - 1 : 1)
                  else
                    m,
              ])),
          mealSellingOptionChanged: (mealId, option) async => emit(state.copyWith(includedMeals: [
                for (final m in state.includedMeals)
                  if (m.mealId == mealId)
                    m.copyWith(
                      sellingOptionId: option.id,
                      sellingOptionLabel: option.label,
                      unitPrice: option.price,
                    )
                  else
                    m,
              ])),
          submitPressed: () => _submit(emit),
        ));
  }

  final CreateOffer _createOffer;

  Future<void> _submit(Emitter<CreateOfferState> emit) async {
    final errors = validateOfferForm(
      name: state.name,
      totalPriceInput: state.totalPriceInput,
      durationDaysInput: state.durationDaysInput,
      includedMealIds: [for (final m in state.includedMeals) m.mealId],
      imageSizeBytes: state.imageSizeBytes,
    );

    if (errors.isNotEmpty) {
      emit(state.copyWith(submitStatus: OfferSubmitStatus.validationFailure(errors)));
      return;
    }

    emit(state.copyWith(submitStatus: const OfferSubmitStatus.submitting()));

    final submission = OfferFormSubmission(
      name: state.name,
      description: state.description,
      totalPrice: double.parse(state.totalPriceInput),
      durationDays: int.parse(state.durationDaysInput),
      isActive: state.isActive,
      imagePath: state.imagePath,
      includedMeals: [
        for (final m in state.includedMeals)
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

    final result = await _createOffer(submission);
    result.fold(
      (offer) => emit(state.copyWith(submitStatus: OfferSubmitStatus.success(offer))),
      (exception) => emit(state.copyWith(submitStatus: OfferSubmitStatus.failure(exception))),
    );
  }
}
