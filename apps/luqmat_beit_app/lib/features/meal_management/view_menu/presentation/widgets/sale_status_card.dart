import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../bloc/stop_selling_cubit.dart';
import '../bloc/stop_selling_state.dart';

/// CK-10's kitchen-wide switch. Tapping never toggles instantly — it
/// always opens a confirmation dialog first (CK-10's business rule), and
/// only dispatches to [StopSellingCubit] on confirm.
class SaleStatusCard extends StatelessWidget {
  const SaleStatusCard({
    super.key,
    required this.isSellingPaused,
    required this.onSellingStatusChanged,
  });

  final bool isSellingPaused;

  /// Invoked after the toggle succeeds, so the page can reload the whole
  /// menu and recompute every meal card's active/inactive visual, not
  /// just this card's text.
  final VoidCallback onSellingStatusChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<StopSellingCubit, StopSellingState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => onSellingStatusChanged(),
          failure: (exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(exception.message)),
            );
          },
        );
      },
      child: Container(
        padding: AppSpace.cardPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.saleStatusLabel, style: textTheme.titleMedium),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    isSellingPaused ? l10n.saleStatusPaused : l10n.saleStatusActive,
                    style: textTheme.bodyMedium?.copyWith(
                      color: isSellingPaused ? scheme.onSurfaceVariant : AppColors.zaatar,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: !isSellingPaused,
              onChanged: (turnOn) => _handleToggle(context, turnOn),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, bool turnOn) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await ConfirmationDialog.show(
      context,
      title: turnOn ? l10n.resumeSellingDialogTitle : l10n.stopSellingDialogTitle,
      message: turnOn ? l10n.resumeSellingDialogBody : l10n.stopSellingDialogBody,
      confirmLabel: l10n.confirmLabel,
      cancelLabel: l10n.cancelLabel,
    );
    if (confirmed != true || !context.mounted) return;
    context.read<StopSellingCubit>().setPaused(!turnOn);
  }
}
