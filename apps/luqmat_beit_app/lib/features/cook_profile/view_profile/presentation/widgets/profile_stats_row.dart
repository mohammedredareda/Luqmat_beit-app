import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// CK-21's performance stats (completed orders, total meals, etc.) are
/// explicitly left undefined by the backlog — "cannot be defined without
/// further requirements... recommend a requirements session before
/// building this." Rather than inventing numbers, this shows only the one
/// confirmed field (phone number) plus a clearly-labeled placeholder for
/// the stats that are still pending product definition.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: AppSpace.cardPadding,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bar_chart, color: scheme.onSurfaceVariant, size: 22),
                const SizedBox(height: AppSpace.xs),
                Text(
                  l10n.statsComingSoonLabel,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpace.m),
        Expanded(
          child: Container(
            padding: AppSpace.cardPadding,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call, color: scheme.primary, size: 22),
                const SizedBox(height: AppSpace.xs),
                Text(
                  l10n.phoneNumberStatLabel,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(color: scheme.onPrimaryContainer),
                ),
                const SizedBox(height: AppSpace.xs),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    phoneNumber,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(color: scheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
