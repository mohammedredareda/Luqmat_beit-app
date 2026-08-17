import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/domain/discount_restriction_type.dart';
import '../../../shared/presentation/bloc/discount_submit_status.dart';
import '../../../shared/presentation/widgets/discount_price_after_row.dart';
import '../../../shared/presentation/widgets/discount_restriction_type_toggle.dart';
import '../bloc/edit_discount_bloc.dart';
import '../bloc/edit_discount_event.dart';
import '../bloc/edit_discount_state.dart';
import '../widgets/edit_discount_skeleton.dart';

String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
  final tokens = fieldErrors[field];
  if (tokens == null || tokens.isEmpty) return null;
  return switch (tokens.first) {
    'required' => l10n.validationRestrictionRequired,
    'outOfRange' => l10n.validationPercentageOutOfRange,
    'invalid' => l10n.genericErrorMessage,
    _ => l10n.genericErrorMessage,
  };
}

/// CK-14 Edit Discount — mirrors the `edit_discount` mockup's flat (no
/// enclosing card) layout: target-meal row, plain percentage field,
/// individually-boxed per-option price rows, a divider, then the
/// "نوع الصلاحية" segmented control with its 2-column remaining/update
/// layout. Save/Cancel live in a fixed bottom bar, matching the mockup —
/// no delete button here (delete stays reachable from the offers list
/// card, per CK-15).
class EditDiscountPage extends StatelessWidget {
  const EditDiscountPage({super.key, required this.discountId});

  final String discountId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditDiscountBloc>()..add(EditDiscountEvent.started(discountId)),
      child: const _EditDiscountView(),
    );
  }
}

class _EditDiscountView extends StatelessWidget {
  const _EditDiscountView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<EditDiscountBloc, EditDiscountState>(
      listener: (context, state) {
        if (state is EditDiscountForm) {
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
      child: BlocBuilder<EditDiscountBloc, EditDiscountState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text(l10n.editDiscountTitle)),
          body: state.when(
            loading: () => const EditDiscountSkeleton(),
            loadError: (exception) => _LoadErrorBody(message: exception.message),
            form: (data) => _FormBody(data: data),
          ),
          bottomNavigationBar: state is EditDiscountForm ? _BottomBar(data: state.data) : null,
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
              onPressed: () =>
                  context.read<EditDiscountBloc>().add(const EditDiscountEvent.retryLoadPressed()),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.data});

  final EditDiscountFormData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bloc = context.read<EditDiscountBloc>();
    final fieldErrors = data.submitStatus.maybeWhen(
      validationFailure: (errors) => errors,
      orElse: () => const <String, List<String>>{},
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        Text(
          l10n.editDiscountSubtitle,
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.xl),
        // Target meal — decision 14: read-only, no re-select control.
        Container(
          padding: AppSpace.cardPadding,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadow.e1,
            border: Border.all(color: scheme.surfaceContainerHighest),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.image),
                child: Image.network(
                  data.mealImageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 64,
                    color: scheme.surfaceContainerHighest,
                    child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.discountTargetMealLabel,
                      style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 2),
                    Text(data.mealName, style: textTheme.titleMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        Text(
          l10n.discountPercentageLabel,
          style: textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpace.s),
        TextFormField(
          initialValue: data.percentageInput,
          onChanged: (value) => bloc.add(EditDiscountEvent.percentageChanged(value)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            suffixText: '%',
            errorText: _fieldError(l10n, fieldErrors, 'percentage'),
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        Text(l10n.discountPricesAfterPerOptionLabel, style: textTheme.labelLarge),
        const SizedBox(height: AppSpace.m),
        if (data.mealSellingOptions.isEmpty)
          DiscountPriceAfterRow(
            label: data.mealName,
            oldPrice: data.mealBasePrice,
            percentage: (double.tryParse(data.percentageInput) ?? 0),
          )
        else
          for (final option in data.mealSellingOptions) ...[
            DiscountPriceAfterRow(
              label: option.label,
              oldPrice: option.price,
              percentage: (double.tryParse(data.percentageInput) ?? 0),
            ),
            const SizedBox(height: AppSpace.s),
          ],
        const SizedBox(height: AppSpace.s),
        Text(
          l10n.discountPricesAfterCaption(data.percentageInput),
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.xl),
        Divider(color: scheme.outlineVariant),
        const SizedBox(height: AppSpace.xl),
        Text(l10n.validityTypeLabel, style: textTheme.labelLarge),
        const SizedBox(height: AppSpace.m),
        DiscountRestrictionTypeToggle(
          value: data.restrictionType,
          durationLabel: l10n.restrictionByDurationLabel,
          usageLabel: l10n.restrictionByUsageLabel,
          onChanged: (type) => bloc.add(EditDiscountEvent.restrictionTypeChanged(type)),
        ),
        const SizedBox(height: AppSpace.m),
        if (data.restrictionType == DiscountRestrictionType.duration)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.remainingDaysDisplay != null)
                Expanded(
                  child: _RemainingChip(
                    icon: Icons.timer_outlined,
                    label: l10n.remainingDaysLabel,
                    value: l10n.remainingDaysValue(data.remainingDaysDisplay!),
                  ),
                ),
              if (data.remainingDaysDisplay != null) const SizedBox(width: AppSpace.m),
              Expanded(
                child: _UpdateField(
                  label: l10n.updateDurationLabel,
                  initialValue: data.durationDaysInput,
                  suffixText: l10n.daysUnitSuffix,
                  errorText: _fieldError(l10n, fieldErrors, 'duration'),
                  onChanged: (value) => bloc.add(EditDiscountEvent.durationDaysChanged(value)),
                ),
              ),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.remainingUsageDisplay != null)
                Expanded(
                  child: _RemainingChip(
                    icon: Icons.confirmation_number_outlined,
                    label: l10n.remainingUsageLabel,
                    value: l10n.remainingUsageValue(data.remainingUsageDisplay!),
                  ),
                ),
              if (data.remainingUsageDisplay != null) const SizedBox(width: AppSpace.m),
              Expanded(
                child: _UpdateField(
                  label: l10n.updateUsageLimitLabel,
                  initialValue: data.usageLimitInput,
                  suffixText: l10n.usesUnitSuffix,
                  errorText: _fieldError(l10n, fieldErrors, 'usageLimit'),
                  onChanged: (value) => bloc.add(EditDiscountEvent.usageLimitChanged(value)),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _RemainingChip extends StatelessWidget {
  const _RemainingChip({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: AppSpace.xs),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.m),
          decoration: BoxDecoration(
            color: AppColors.zaatarContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.zaatar),
              const SizedBox(width: AppSpace.xs),
              Flexible(
                child: Text(
                  value,
                  style: textTheme.labelLarge?.copyWith(color: AppColors.zaatar),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpdateField extends StatelessWidget {
  const _UpdateField({
    required this.label,
    required this.initialValue,
    required this.suffixText,
    required this.errorText,
    required this.onChanged,
  });

  final String label;
  final String initialValue;
  final String suffixText;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: AppSpace.xs),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          decoration: InputDecoration(suffixText: suffixText, errorText: errorText),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.data});

  final EditDiscountFormData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bloc = context.read<EditDiscountBloc>();
    final isSubmitting = data.submitStatus is DiscountSubmitSubmitting;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.m, AppSpace.l, AppSpace.m),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHighest,
                  foregroundColor: scheme.onSurface,
                  side: BorderSide.none,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancelLabel),
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () => bloc.add(const EditDiscountEvent.submitPressed()),
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.saveDiscountChangesCta),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
