import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';
import 'package:luqmat_beit_app/shared/presentation/widgets/image_picker_field.dart';

import '../../../shared/domain/usecases/lookup_meal.dart';
import '../../../shared/presentation/bloc/offer_meal_draft.dart';
import '../../../shared/presentation/bloc/offer_submit_status.dart';
import '../../../shared/presentation/widgets/select_meal_popup.dart';
import '../../../shared/presentation/widgets/select_selling_option_dialog.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';
import '../bloc/create_offer_state.dart';

/// CK-13 Create Offer.
class CreateOfferPage extends StatelessWidget {
  const CreateOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateOfferBloc>(),
      child: const _CreateOfferView(),
    );
  }
}

String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
  final tokens = fieldErrors[field];
  if (tokens == null || tokens.isEmpty) return null;
  return switch (tokens.first) {
    'required' => l10n.validationRequiredField,
    'zeroMeals' => l10n.validationZeroMeals,
    'nonPositive' => l10n.validationNonPositivePrice,
    'imageTooLarge' => l10n.validationImageTooLarge,
    _ => l10n.genericErrorMessage,
  };
}

Future<void> _onAddDish(BuildContext context) async {
  final bloc = context.read<CreateOfferBloc>();
  final excluded = {for (final m in bloc.state.includedMeals) m.mealId};
  final meal = await showSelectMealPopup(context, excludedMealIds: excluded);
  if (meal == null || !context.mounted) return;
  if (meal.hasVariations) {
    final option = await showSelectSellingOptionDialog(context, meal: meal);
    if (option == null) return; // cancelled — dish not added
    if (!context.mounted) return;
    bloc.add(CreateOfferEvent.mealAdded(meal, option));
  } else {
    bloc.add(CreateOfferEvent.mealAdded(meal, null));
  }
}

Future<void> _onChangeSellingOption(BuildContext context, String mealId) async {
  final bloc = context.read<CreateOfferBloc>();
  final lookupMeal = getIt<LookupMeal>();
  final result = await lookupMeal(mealId);
  if (!context.mounted) return;
  result.fold((meal) async {
    final option = await showSelectSellingOptionDialog(context, meal: meal);
    if (option == null || !context.mounted) return;
    bloc.add(CreateOfferEvent.mealSellingOptionChanged(mealId, option));
  }, (_) {});
}

class _CreateOfferView extends StatelessWidget {
  const _CreateOfferView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<CreateOfferBloc, CreateOfferState>(
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
        appBar: AppBar(title: Text(l10n.createOfferTitle)),
        body: BlocBuilder<CreateOfferBloc, CreateOfferState>(
          builder: (context, state) {
            final fieldErrors = state.submitStatus.maybeWhen(
              validationFailure: (errors) => errors,
              orElse: () => const <String, List<String>>{},
            );
            final bloc = context.read<CreateOfferBloc>();
            final isSubmitting = state.submitStatus is OfferSubmitSubmitting;

            return ListView(
              padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
              children: [
                FormSectionCard(
                  title: l10n.offerNameLabel,
                  children: [
                    ImagePickerField(
                      imagePath: state.imagePath,
                      hintLabel: l10n.offerImagePickerHint,
                      changeLabel: l10n.changeOfferImageCta,
                      onImagePicked: (path, sizeBytes) =>
                          bloc.add(CreateOfferEvent.imagePicked(path, sizeBytes)),
                      errorText: _fieldError(l10n, fieldErrors, 'image'),
                    ),
                    const SizedBox(height: AppSpace.m),
                    TextFormField(
                      initialValue: state.name,
                      onChanged: (value) => bloc.add(CreateOfferEvent.nameChanged(value)),
                      decoration: InputDecoration(
                        labelText: l10n.offerNameLabel,
                        hintText: l10n.offerNameHint,
                        errorText: _fieldError(l10n, fieldErrors, 'name'),
                      ),
                    ),
                    const SizedBox(height: AppSpace.m),
                    TextFormField(
                      initialValue: state.description,
                      onChanged: (value) => bloc.add(CreateOfferEvent.descriptionChanged(value)),
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: l10n.offerDescriptionLabel,
                        hintText: l10n.offerDescriptionHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.xl),
                FormSectionCard(
                  title: l10n.includedMealsSectionTitle,
                  children: [
                    Text(
                      l10n.includedMealsCountLabel(state.includedMeals.length),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpace.s),
                    if (state.includedMeals.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpace.m),
                        child: Text(l10n.includedMealsEmptyBody),
                      )
                    else
                      for (final meal in state.includedMeals)
                        _OfferMealRow(
                          meal: meal,
                          onSellingOptionTap: meal.sellingOptionId != null
                              ? () => _onChangeSellingOption(context, meal.mealId)
                              : null,
                          onIncrement: () =>
                              bloc.add(CreateOfferEvent.mealQuantityIncremented(meal.mealId)),
                          onDecrement: () =>
                              bloc.add(CreateOfferEvent.mealQuantityDecremented(meal.mealId)),
                          onRemove: () => bloc.add(CreateOfferEvent.mealRemoved(meal.mealId)),
                        ),
                    if (_fieldError(l10n, fieldErrors, 'meals') != null) ...[
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        _fieldError(l10n, fieldErrors, 'meals')!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                    const SizedBox(height: AppSpace.s),
                    OutlinedButton.icon(
                      onPressed: () => _onAddDish(context),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.addDishCta),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.xl),
                FormSectionCard(
                  title: l10n.offerTotalPriceLabel,
                  children: [
                    TextFormField(
                      initialValue: state.totalPriceInput,
                      onChanged: (value) => bloc.add(CreateOfferEvent.totalPriceChanged(value)),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: l10n.offerTotalPriceLabel,
                        suffixText: l10n.currencySuffix,
                        errorText: _fieldError(l10n, fieldErrors, 'totalPrice'),
                      ),
                    ),
                    const SizedBox(height: AppSpace.m),
                    TextFormField(
                      initialValue: state.durationDaysInput,
                      onChanged: (value) => bloc.add(CreateOfferEvent.durationDaysChanged(value)),
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: l10n.offerDurationDaysLabel,
                        errorText: _fieldError(l10n, fieldErrors, 'durationDays'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.xl),
                FormSectionCard(
                  title: l10n.offerStatusSectionTitle,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.offerStatusHelperText,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Switch(
                          value: state.isActive,
                          onChanged: (value) => bloc.add(CreateOfferEvent.activeToggled(value)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.xl),
                ElevatedButton(
                  onPressed:
                      isSubmitting ? null : () => bloc.add(const CreateOfferEvent.submitPressed()),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.createOfferCta),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OfferMealRow extends StatelessWidget {
  const _OfferMealRow({
    required this.meal,
    required this.onSellingOptionTap,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final OfferMealDraft meal;
  final VoidCallback? onSellingOptionTap;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: Image.network(
              meal.mealImageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: scheme.surfaceContainerHighest,
                child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(meal.mealName, style: textTheme.bodyLarge, maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                if (meal.sellingOptionLabel != null)
                  GestureDetector(
                    onTap: onSellingOptionTap,
                    child: Chip(
                      label: Text(meal.sellingOptionLabel!),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle_outline),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          Text('${meal.quantity}', style: textTheme.bodyLarge),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle_outline),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.delete_outline, color: scheme.error),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }
}
