import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';
import 'package:luqmat_beit_app/shared/presentation/widgets/image_picker_field.dart';

import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/widgets/meal_basic_info_section.dart';
import '../../../shared/presentation/widgets/meal_category_picker.dart';
import '../../../shared/presentation/widgets/meal_preorder_time_field.dart';
import '../../../shared/presentation/widgets/meal_pricing_section.dart';
import '../bloc/create_meal_bloc.dart';
import '../bloc/create_meal_event.dart';
import '../bloc/create_meal_state.dart';

/// CK-07 Create Meal.
class CreateMealPage extends StatelessWidget {
  const CreateMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateMealBloc>(),
      child: const _CreateMealView(),
    );
  }
}

class _CreateMealView extends StatelessWidget {
  const _CreateMealView();

  String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
    final tokens = fieldErrors[field];
    if (tokens == null || tokens.isEmpty) return null;
    return switch (tokens.first) {
      'required' => l10n.validationRequiredField,
      'zeroVariations' => l10n.validationZeroVariations,
      'nonPositive' => l10n.validationNonPositivePrice,
      'imageTooLarge' => l10n.validationImageTooLarge,
      _ => l10n.genericErrorMessage,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<CreateMealBloc, CreateMealState>(
      listener: (context, state) {
        state.submitStatus.whenOrNull(
          success: (_) => Navigator.of(context).pop(true),
          failure: (exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(exception.message)),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.addMealTitle)),
        body: BlocBuilder<CreateMealBloc, CreateMealState>(
          builder: (context, state) {
            final fieldErrors = state.submitStatus.maybeWhen(
              validationFailure: (errors) => errors,
              orElse: () => const <String, List<String>>{},
            );
            final bloc = context.read<CreateMealBloc>();
            final isSubmitting = state.submitStatus is MealSubmitSubmitting;

            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpace.l,
                    AppSpace.l,
                    AppSpace.l,
                    AppSpace.xxl + 56,
                  ),
                  children: [
                    ImagePickerField(
                      imagePath: state.imagePath,
                      hintLabel: l10n.mealImagePickerHint,
                      changeLabel: l10n.changeMealImageCta,
                      onImagePicked: (path, sizeBytes) =>
                          bloc.add(CreateMealEvent.imagePicked(path, sizeBytes)),
                      errorText: _fieldError(l10n, fieldErrors, 'image'),
                    ),
                    const SizedBox(height: AppSpace.xl),
                    MealBasicInfoSection(
                      sectionTitle: l10n.basicInfoSectionTitle,
                      name: state.name,
                      nameLabel: l10n.mealNameLabel,
                      nameHint: l10n.mealNameHint,
                      nameError: _fieldError(l10n, fieldErrors, 'name'),
                      onNameChanged: (value) => bloc.add(CreateMealEvent.nameChanged(value)),
                      description: state.description,
                      descriptionLabel: l10n.descriptionLabel,
                      descriptionHint: l10n.descriptionHint,
                      descriptionError: _fieldError(l10n, fieldErrors, 'description'),
                      onDescriptionChanged: (value) =>
                          bloc.add(CreateMealEvent.descriptionChanged(value)),
                    ),
                    const SizedBox(height: AppSpace.xl),
                    MealCategoryPicker(
                      sectionTitle: l10n.categorySectionTitle,
                      selectedCategoryIds: state.categoryIds,
                      onToggle: (id) => bloc.add(CreateMealEvent.categoryToggled(id)),
                      errorLabel: l10n.genericErrorMessage,
                      retryLabel: l10n.retryLabel,
                    ),
                    const SizedBox(height: AppSpace.xl),
                    MealPreorderTimeField(
                      sectionTitle: l10n.preorderTimeLabel,
                      label: l10n.preorderTimeLabel,
                      unitLabel: l10n.preorderHoursUnit,
                      value: state.preorderHoursInput,
                      onChanged: (value) => bloc.add(CreateMealEvent.preorderHoursChanged(value)),
                      errorText: _fieldError(l10n, fieldErrors, 'preorderHours'),
                    ),
                    const SizedBox(height: AppSpace.xl),
                    MealPricingSection(
                      sectionTitle: l10n.pricingSectionTitle,
                      toggleLabel: l10n.sellWithVariationsToggle,
                      sellWithVariations: state.sellWithVariations,
                      onToggleChanged: (enabled) =>
                          bloc.add(CreateMealEvent.variationsToggled(enabled)),
                      priceLabel: l10n.priceLabel,
                      currencySuffix: l10n.currencySuffix,
                      priceInput: state.priceInput,
                      onPriceChanged: (value) => bloc.add(CreateMealEvent.priceChanged(value)),
                      priceError: _fieldError(l10n, fieldErrors, 'price'),
                      variations: state.variations,
                      variationSizeHint: l10n.variationSizeHint,
                      onVariationLabelChanged: (localId, value) =>
                          bloc.add(CreateMealEvent.variationLabelChanged(localId, value)),
                      onVariationPriceChanged: (localId, value) =>
                          bloc.add(CreateMealEvent.variationPriceChanged(localId, value)),
                      onVariationRemoved: (localId) =>
                          bloc.add(CreateMealEvent.variationRemoved(localId)),
                      onVariationAdded: () => bloc.add(const CreateMealEvent.variationAdded()),
                      addVariationLabel: l10n.addVariationCta,
                      variationsError: _fieldError(l10n, fieldErrors, 'variations'),
                    ),
                  ],
                ),
                Positioned(
                  left: AppSpace.l,
                  right: AppSpace.l,
                  bottom: AppSpace.l,
                  child: ElevatedButton.icon(
                    onPressed:
                        isSubmitting ? null : () => bloc.add(const CreateMealEvent.submitPressed()),
                    icon: isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.done_all),
                    label: Text(l10n.addMealCta),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
