import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

/// The 3 sumac-tinted stat tiles from `profile_with_stats`. Values are
/// plain integers with no thousands separator (R-15's Latin-numeral rule
/// is satisfied by default — `Text` never localizes digits on its own).
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.completedOrdersCount,
    required this.totalMealsCount,
    required this.phoneNumber,
  });

  final int completedOrdersCount;
  final int totalMealsCount;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.check_circle,
            label: l10n.completedOrdersStatLabel,
            value: '$completedOrdersCount',
          ),
        ),
        const SizedBox(width: AppSpace.m),
        Expanded(
          child: _StatTile(
            icon: Icons.restaurant,
            label: l10n.totalMealsStatLabel,
            value: '$totalMealsCount',
          ),
        ),
        const SizedBox(width: AppSpace.m),
        Expanded(
          child: _StatTile(
            icon: Icons.call,
            label: l10n.phoneNumberStatLabel,
            value: phoneNumber,
            valueDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueDirection,
  });

  final IconData icon;
  final String label;
  final String value;
  final TextDirection? valueDirection;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: scheme.primary, size: 22),
          const SizedBox(height: AppSpace.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(color: scheme.onPrimaryContainer),
          ),
          const SizedBox(height: AppSpace.xs),
          Directionality(
            textDirection: valueDirection ?? Directionality.of(context),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(color: scheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
