import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/meal_form_submission.dart';
import '../../../domain/meal_form_validator.dart';
import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/bloc/meal_variation_draft.dart';
import '../../domain/usecases/create_meal.dart';
import 'create_meal_event.dart';
import 'create_meal_state.dart';

/// CK-07 Create Meal — E1–E4 are 4 UI-distinct exception flows, which is
/// exactly the architecture doc's ">1 UI-distinct exception flow → Bloc"
/// criterion (contrast with `ViewMenuCubit`'s single fetch-and-display).
@injectable
class CreateMealBloc extends Bloc<CreateMealEvent, CreateMealState> {
  CreateMealBloc(this._createMeal) : super(const CreateMealState()) {
    // Every branch returns a Future so `on<CreateMealEvent>` can await the
    // whole `when(...)` uniformly — required so `submitPressed`'s async
    // work finishes (and keeps `emit` valid) before the handler completes.
    on<CreateMealEvent>((event, emit) => event.when(
          nameChanged: (value) async => emit(state.copyWith(name: value)),
          descriptionChanged: (value) async => emit(state.copyWith(description: value)),
          categoryToggled: (categoryId) async {
            final categoryIds = Set<String>.of(state.categoryIds);
            if (!categoryIds.remove(categoryId)) categoryIds.add(categoryId);
            emit(state.copyWith(categoryIds: categoryIds));
            return null;
          },
          preorderHoursChanged: (value) async =>
              emit(state.copyWith(preorderHoursInput: value)),
          variationsToggled: (enabled) async =>
              emit(state.copyWith(sellWithVariations: enabled)),
          priceChanged: (value) async => emit(state.copyWith(priceInput: value)),
          variationAdded: () async => emit(state.copyWith(variations: [
                ...state.variations,
                MealVariationDraft(localId: DateTime.now().microsecondsSinceEpoch.toString()),
              ])),
          variationRemoved: (localId) async => emit(state.copyWith(
                variations: state.variations.where((v) => v.localId != localId).toList(),
              )),
          variationLabelChanged: (localId, value) async => emit(state.copyWith(
                variations: [
                  for (final v in state.variations)
                    if (v.localId == localId) v.copyWith(label: value) else v,
                ],
              )),
          variationPriceChanged: (localId, value) async => emit(state.copyWith(
                variations: [
                  for (final v in state.variations)
                    if (v.localId == localId) v.copyWith(priceInput: value) else v,
                ],
              )),
          imagePicked: (path, sizeBytes) async =>
              emit(state.copyWith(imagePath: path, imageSizeBytes: sizeBytes)),
          submitPressed: () => _submit(emit),
        ));
  }

  final CreateMeal _createMeal;

  Future<void> _submit(Emitter<CreateMealState> emit) async {
    final errors = validateMealForm(
      name: state.name,
      description: state.description,
      imagePath: state.imagePath,
      imageSizeBytes: state.imageSizeBytes,
      preorderHoursInput: state.preorderHoursInput,
      sellWithVariations: state.sellWithVariations,
      priceInput: state.priceInput,
      variations: [
        for (final v in state.variations) (label: v.label, priceInput: v.priceInput),
      ],
    );

    if (errors.isNotEmpty) {
      emit(state.copyWith(submitStatus: MealSubmitStatus.validationFailure(errors)));
      return;
    }

    emit(state.copyWith(submitStatus: const MealSubmitStatus.submitting()));

    final submission = MealFormSubmission(
      name: state.name,
      description: state.description,
      imagePath: state.imagePath!,
      categoryIds: state.categoryIds.toList(),
      preorderHours: int.parse(state.preorderHoursInput),
      price: state.sellWithVariations ? null : double.parse(state.priceInput),
      sellingOptions: state.sellWithVariations
          ? [
              for (final v in state.variations)
                MealVariationInput(label: v.label, price: double.parse(v.priceInput)),
            ]
          : const [],
    );

    final result = await _createMeal(submission);
    result.fold(
      (meal) => emit(state.copyWith(submitStatus: MealSubmitStatus.success(meal))),
      (exception) => emit(state.copyWith(submitStatus: MealSubmitStatus.failure(exception))),
    );
  }
}
