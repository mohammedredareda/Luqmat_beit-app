import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/meal_form_submission.dart';
import '../../../domain/meal_form_validator.dart';
import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/bloc/meal_variation_draft.dart';
import '../../domain/usecases/get_meal.dart';
import '../../domain/usecases/update_meal.dart';
import 'edit_meal_event.dart';
import 'edit_meal_state.dart';

class EditMealBloc extends Bloc<EditMealEvent, EditMealState> {
  EditMealBloc(this._getMeal, this._updateMeal) : super(const EditMealState.loading()) {
    on<EditMealEvent>((event, emit) => event.when(
          started: (mealId) => _load(mealId, emit),
          retryLoadPressed: () async {
            final mealId = _lastMealId;
            if (mealId != null) await _load(mealId, emit);
            return null;
          },
          nameChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(name: value)),
          descriptionChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(description: value)),
          categoryToggled: (categoryId) async => _updateForm(emit, (data) {
                final categoryIds = Set<String>.of(data.categoryIds);
                if (!categoryIds.remove(categoryId)) categoryIds.add(categoryId);
                return data.copyWith(categoryIds: categoryIds);
              }),
          preorderHoursChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(preorderHoursInput: value)),
          variationsToggled: (enabled) async =>
              _updateForm(emit, (data) => data.copyWith(sellWithVariations: enabled)),
          priceChanged: (value) async =>
              _updateForm(emit, (data) => data.copyWith(priceInput: value)),
          variationAdded: () async => _updateForm(
                emit,
                (data) => data.copyWith(variations: [
                  ...data.variations,
                  MealVariationDraft(localId: DateTime.now().microsecondsSinceEpoch.toString()),
                ]),
              ),
          variationRemoved: (localId) async => _updateForm(
                emit,
                (data) => data.copyWith(
                  variations: data.variations.where((v) => v.localId != localId).toList(),
                ),
              ),
          variationLabelChanged: (localId, value) async => _updateForm(
                emit,
                (data) => data.copyWith(variations: [
                  for (final v in data.variations)
                    if (v.localId == localId) v.copyWith(label: value) else v,
                ]),
              ),
          variationPriceChanged: (localId, value) async => _updateForm(
                emit,
                (data) => data.copyWith(variations: [
                  for (final v in data.variations)
                    if (v.localId == localId) v.copyWith(priceInput: value) else v,
                ]),
              ),
          imagePicked: (path, sizeBytes) async => _updateForm(
                emit,
                (data) => data.copyWith(imagePath: path, imageSizeBytes: sizeBytes),
              ),
          availabilityToggled: (isAvailable) async =>
              _updateForm(emit, (data) => data.copyWith(isAvailable: isAvailable)),
          submitPressed: () => _submit(emit),
        ));
  }

  final GetMeal _getMeal;
  final UpdateMeal _updateMeal;
  String? _lastMealId;

  void _updateForm(
    Emitter<EditMealState> emit,
    EditMealFormData Function(EditMealFormData data) transform,
  ) {
    final current = state;
    if (current is EditMealForm) emit(EditMealState.form(transform(current.data)));
  }

  Future<void> _load(String mealId, Emitter<EditMealState> emit) async {
    _lastMealId = mealId;
    emit(const EditMealState.loading());
    final result = await _getMeal(mealId);
    result.fold(
      (meal) => emit(EditMealState.form(EditMealFormData(
        mealId: meal.id,
        name: meal.name,
        description: meal.description,
        categoryIds: meal.categoryIds.toSet(),
        preorderHoursInput: meal.preparingDurationMinutes.toString(),
        sellWithVariations: meal.hasVariations,
        priceInput: meal.hasVariations ? '' : (meal.singlePrice?.toString() ?? ''),
        variations: [
          for (var i = 0; i < meal.sellingOptions.length; i++)
            MealVariationDraft(
              localId: 'existing-$i',
              label: meal.sellingOptions[i].label,
              priceInput: meal.sellingOptions[i].price.toString(),
            ),
        ],
        imagePath: meal.imageUrl,
        isAvailable: !meal.isStopped,
      ))),
      (exception) => emit(EditMealState.loadError(exception)),
    );
  }

  Future<void> _submit(Emitter<EditMealState> emit) async {
    final formState = state;
    if (formState is! EditMealForm) return;
    final data = formState.data;

    final errors = validateMealForm(
      name: data.name,
      description: data.description,
      imagePath: data.imagePath,
      imageSizeBytes: data.imageSizeBytes,
      preorderHoursInput: data.preorderHoursInput,
      sellWithVariations: data.sellWithVariations,
      priceInput: data.priceInput,
      variations: [
        for (final v in data.variations) (label: v.label, priceInput: v.priceInput),
      ],
    );

    if (errors.isNotEmpty) {
      emit(EditMealState.form(data.copyWith(submitStatus: MealSubmitStatus.validationFailure(errors))));
      return;
    }

    emit(EditMealState.form(data.copyWith(submitStatus: const MealSubmitStatus.submitting())));

    final submission = MealFormSubmission(
      name: data.name,
      description: data.description,
      imagePath: data.imagePath!,
      categoryIds: data.categoryIds.toList(),
      preorderHours: int.parse(data.preorderHoursInput),
      price: data.sellWithVariations ? null : double.parse(data.priceInput),
      sellingOptions: data.sellWithVariations
          ? [
              for (final v in data.variations)
                MealVariationInput(label: v.label, price: double.parse(v.priceInput)),
            ]
          : const [],
    );

    final result = await _updateMeal(data.mealId, submission, isStopped: !data.isAvailable);
    result.fold(
      (meal) => emit(
        EditMealState.form(data.copyWith(submitStatus: MealSubmitStatus.success(meal))),
      ),
      (exception) => emit(
        EditMealState.form(data.copyWith(submitStatus: MealSubmitStatus.failure(exception))),
      ),
    );
  }
}
