import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../../shared/presentation/widgets/discount_price_after_row.dart';
import '../../../shared/presentation/widgets/required_field_label.dart';
import '../../../shared/presentation/widgets/select_meal_popup.dart';
import '../bloc/create_discount_bloc.dart';
import '../bloc/create_discount_event.dart';
import '../bloc/create_discount_state.dart';

/// CK-12 Create Discount — mirrors `create_discount_with_meal_selection`'s
/// mockup: one white card holding both the "تفاصيل الخصم" and "تحديد نوع
/// القيد" sections (split by a divider), then Save + Cancel below it.
class CreateDiscountPage extends StatelessWidget {
  const CreateDiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateDiscountBloc>(),
      child: const _CreateDiscountView(),
    );
  }
}

String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
  final tokens = fieldErrors[field];
  if (tokens == null || tokens.isEmpty) return null;
  if (field == 'meal') return l10n.validationMealRequired;
  return switch (tokens.first) {
    'required' => l10n.validationRestrictionRequired,
    'outOfRange' => l10n.validationPercentageOutOfRange,
    'invalid' => l10n.genericErrorMessage,
    _ => l10n.genericErrorMessage,
  };
}

class _CreateDiscountView extends StatelessWidget {
  const _CreateDiscountView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<CreateDiscountBloc, CreateDiscountState>(
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
        appBar: AppBar(title: Text(l10n.createDiscountTitle)),
        body: BlocBuilder<CreateDiscountBloc, CreateDiscountState>(
          builder: (context, state) => _FormBody(state: state),
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.state});

  final CreateDiscountState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bloc = context.read<CreateDiscountBloc>();
    final isSubmitting = state.submitStatus is DiscountSubmitSubmitting;
    final fieldErrors = state.submitStatus.maybeWhen(
      validationFailure: (errors) => errors,
      orElse: () => const <String, List<String>>{},
    );
    final percentage = double.tryParse(state.percentageInput);

    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpace.l),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadow.e1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.discountDetailsSectionTitle, style: textTheme.titleMedium),
              const SizedBox(height: AppSpace.l),
              RequiredFieldLabel(l10n.selectMealFieldLabel),
              const SizedBox(height: AppSpace.s),
              InkWell(
                borderRadius: BorderRadius.circular(AppRadius.input),
                onTap: () async {
                  final meal = await showSelectMealPopup(context, excludedMealIds: const {});
                  if (meal != null && context.mounted) {
                    bloc.add(CreateDiscountEvent.mealSelected(meal));
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: l10n.selectMealFieldLabel,
                    suffixIcon: const Icon(Icons.expand_more),
                    errorText: _fieldError(l10n, fieldErrors, 'meal'),
                  ),
                  child: Text(
                    state.selectedMeal?.name ?? '',
                    style: state.selectedMeal == null
                        ? textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)
                        : textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.l),
              RequiredFieldLabel(l10n.discountPercentageLabel),
              const SizedBox(height: AppSpace.s),
              TextFormField(
                initialValue: state.percentageInput,
                onChanged: (value) => bloc.add(CreateDiscountEvent.percentageChanged(value)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: '0',
                  suffixText: '%',
                  errorText: _fieldError(l10n, fieldErrors, 'percentage'),
                ),
              ),
              if (state.selectedMeal != null && percentage != null) ...[
                const SizedBox(height: AppSpace.l),
                Text(l10n.discountPricesAfterPerOptionLabel, style: textTheme.labelLarge),
                const SizedBox(height: AppSpace.s),
                if (!state.selectedMeal!.hasVariations)
                  DiscountPriceAfterRow(
                    label: state.selectedMeal!.name,
                    oldPrice: state.selectedMeal!.startingPrice,
                    percentage: percentage,
                  )
                else
                  for (final option in state.selectedMeal!.sellingOptions)
                    DiscountPriceAfterRow(
                      label: option.label,
                      oldPrice: option.price,
                      percentage: percentage,
                    ),
                const SizedBox(height: AppSpace.xs),
                Text(
                  l10n.discountPricesAfterCaption(state.percentageInput),
                  style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
              const SizedBox(height: AppSpace.xl),
              Divider(color: scheme.outlineVariant),
              const SizedBox(height: AppSpace.xl),
              Text(l10n.restrictionTypeLabel, style: textTheme.titleMedium),
              const SizedBox(height: AppSpace.l),
              RequiredFieldLabel(l10n.offerDurationDaysLabel),
              const SizedBox(height: AppSpace.s),
              TextFormField(
                initialValue: state.durationDaysInput,
                onChanged: (value) => bloc.add(CreateDiscountEvent.durationDaysChanged(value)),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: '7',
                  errorText: _fieldError(l10n, fieldErrors, 'duration'),
                ),
              ),
              const SizedBox(height: AppSpace.l),
              Text(l10n.usageLimitFieldLabel, style: textTheme.labelLarge),
              const SizedBox(height: AppSpace.s),
              TextFormField(
                initialValue: state.usageLimitInput,
                onChanged: (value) => bloc.add(CreateDiscountEvent.usageLimitChanged(value)),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: l10n.usageLimitHint,
                  errorText: _fieldError(l10n, fieldErrors, 'usageLimit'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        ElevatedButton(
          onPressed:
              isSubmitting ? null : () => bloc.add(const CreateDiscountEvent.submitPressed()),
          child: Text(l10n.saveDiscountCta),
        ),
        const SizedBox(height: AppSpace.s),
        Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelLabel),
          ),
        ),
      ],
    );
  }
}
