import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';
import 'package:cook_app/shared/presentation/widgets/image_picker_field.dart';

import '../../../domain/meal_category.dart';
import '../../../shared/presentation/bloc/meal_submit_status.dart';
import '../../../shared/presentation/widgets/delete_meal_confirmation.dart';
import '../../../shared/presentation/widgets/meal_basic_info_section.dart';
import '../../../shared/presentation/widgets/meal_category_chips_section.dart';
import '../../../shared/presentation/widgets/meal_preorder_time_field.dart';
import '../../../shared/presentation/widgets/meal_pricing_section.dart';
import '../bloc/edit_meal_bloc.dart';
import '../bloc/edit_meal_event.dart';
import '../bloc/edit_meal_state.dart';

/// CK-08 Edit Meal.
class EditMealPage extends StatelessWidget {
  const EditMealPage({super.key, required this.mealId});

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditMealBloc>()..add(EditMealEvent.started(mealId)),
      child: const _EditMealView(),
    );
  }
}

class _EditMealView extends StatelessWidget {
  const _EditMealView();

  String _categoryLabel(AppLocalizations l10n, MealCategory category) => switch (category) {
        MealCategory.mainDishes => l10n.categoryMainDishes,
        MealCategory.pastries => l10n.categoryPastries,
        MealCategory.desserts => l10n.categoryDesserts,
        MealCategory.appetizers => l10n.categoryAppetizers,
        MealCategory.beverages => l10n.categoryBeverages,
      };

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

    return BlocListener<EditMealBloc, EditMealState>(
      listener: (context, state) {
        if (state is EditMealForm) {
          state.data.submitStatus.whenOrNull(
            success: (_) => Navigator.of(context).pop(true),
            failure: (exception) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(exception.message)),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.editMealTitle)),
        body: BlocBuilder<EditMealBloc, EditMealState>(
          builder: (context, state) => state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loadError: (exception) => _LoadErrorBody(message: exception.message),
            form: (data) => _FormBody(
              data: data,
              categoryLabel: (category) => _categoryLabel(l10n, category),
              fieldError: (field) => _fieldError(
                l10n,
                data.submitStatus.maybeWhen(
                  validationFailure: (errors) => errors,
                  orElse: () => const <String, List<String>>{},
                ),
                field,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadErrorBody extends StatelessWidget {
  const _LoadErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: AppSpace.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.l),
            OutlinedButton(
              onPressed: () => context.read<EditMealBloc>().add(const EditMealEvent.retryLoadPressed()),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({
    required this.data,
    required this.categoryLabel,
    required this.fieldError,
  });

  final EditMealFormData data;
  final String Function(MealCategory) categoryLabel;
  final String? Function(String field) fieldError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bloc = context.read<EditMealBloc>();
    final isSubmitting = data.submitStatus is MealSubmitSubmitting;

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        ImagePickerField(
          imagePath: data.imagePath,
          hintLabel: l10n.mealImagePickerHint,
          changeLabel: l10n.changeMealImageCta,
          onImagePicked: (path, sizeBytes) => bloc.add(EditMealEvent.imagePicked(path, sizeBytes)),
          errorText: fieldError('image'),
        ),
        const SizedBox(height: AppSpace.xl),
        MealBasicInfoSection(
          sectionTitle: l10n.basicInfoSectionTitle,
          name: data.name,
          nameLabel: l10n.mealNameLabel,
          nameHint: l10n.mealNameHint,
          nameError: fieldError('name'),
          onNameChanged: (value) => bloc.add(EditMealEvent.nameChanged(value)),
          description: data.description,
          descriptionLabel: l10n.descriptionLabel,
          descriptionHint: l10n.descriptionHint,
          descriptionError: fieldError('description'),
          onDescriptionChanged: (value) => bloc.add(EditMealEvent.descriptionChanged(value)),
        ),
        const SizedBox(height: AppSpace.xl),
        MealCategoryChipsSection(
          sectionTitle: l10n.categorySectionTitle,
          selectedCategoryIds: data.categoryIds,
          onToggle: (id) => bloc.add(EditMealEvent.categoryToggled(id)),
          labelBuilder: categoryLabel,
        ),
        const SizedBox(height: AppSpace.xl),
        MealPreorderTimeField(
          sectionTitle: l10n.preorderTimeLabel,
          label: l10n.preorderTimeLabel,
          unitLabel: l10n.preorderHoursUnit,
          value: data.preorderHoursInput,
          onChanged: (value) => bloc.add(EditMealEvent.preorderHoursChanged(value)),
          errorText: fieldError('preorderHours'),
        ),
        const SizedBox(height: AppSpace.xl),
        MealPricingSection(
          sectionTitle: l10n.pricingSectionTitle,
          toggleLabel: l10n.sellWithVariationsToggle,
          sellWithVariations: data.sellWithVariations,
          onToggleChanged: (enabled) => bloc.add(EditMealEvent.variationsToggled(enabled)),
          priceLabel: l10n.priceLabel,
          currencySuffix: l10n.currencySuffix,
          priceInput: data.priceInput,
          onPriceChanged: (value) => bloc.add(EditMealEvent.priceChanged(value)),
          priceError: fieldError('price'),
          variations: data.variations,
          variationSizeHint: l10n.variationSizeHint,
          onVariationLabelChanged: (localId, value) =>
              bloc.add(EditMealEvent.variationLabelChanged(localId, value)),
          onVariationPriceChanged: (localId, value) =>
              bloc.add(EditMealEvent.variationPriceChanged(localId, value)),
          onVariationRemoved: (localId) => bloc.add(EditMealEvent.variationRemoved(localId)),
          onVariationAdded: () => bloc.add(const EditMealEvent.variationAdded()),
          addVariationLabel: l10n.addVariationCta,
          variationsError: fieldError('variations'),
        ),
        const SizedBox(height: AppSpace.xl),
        FormSectionCard(
          title: l10n.availabilitySectionTitle,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(l10n.availabilityHelperText, style: Theme.of(context).textTheme.bodyMedium),
                ),
                Switch(
                  value: data.isAvailable,
                  onChanged: (value) => bloc.add(EditMealEvent.availabilityToggled(value)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        ElevatedButton(
          onPressed: isSubmitting ? null : () => bloc.add(const EditMealEvent.submitPressed()),
          child: Text(l10n.saveMealChangesCta),
        ),
        const SizedBox(height: AppSpace.m),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: scheme.error,
            side: BorderSide(color: scheme.error, width: 1.5),
          ),
          onPressed: () => showDeleteMealConfirmation(
            context,
            mealId: data.mealId,
            onDeleted: () {
              if (context.mounted) Navigator.of(context).pop(true);
            },
          ),
          child: Text(l10n.deleteMealTitle),
        ),
      ],
    );
  }
}
