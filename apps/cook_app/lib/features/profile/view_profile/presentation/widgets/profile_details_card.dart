import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../domain/availability_time_formatter.dart';
import '../../../presentation/weekday_label.dart';

/// Sunday-first display order — matches [Weekday]'s declaration order and
/// the Arabic-locale week used throughout this app.
const _weekdayDisplayOrder = Weekday.values;

/// The bio / availability / address details card from `profile_with_stats`
/// — one bordered card, three subsections separated by dividers.
class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({
    super.key,
    required this.bio,
    required this.availabilityDays,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    required this.address,
  });

  final String bio;
  final Set<Weekday> availabilityDays;
  final AvailabilityTime availabilityStartTime;
  final AvailabilityTime availabilityEndTime;
  final String address;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            icon: Icons.description_outlined,
            title: l10n.aboutMeSectionTitle,
            child: Text(bio, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const Divider(),
          _Section(
            icon: Icons.schedule,
            title: l10n.availabilityHoursSectionTitle,
            child: Wrap(
              spacing: AppSpace.s,
              runSpacing: AppSpace.s,
              children: [
                for (final day in _weekdayDisplayOrder)
                  if (availabilityDays.contains(day)) _Pill(label: weekdayLabel(l10n, day)),
                _Pill(
                  label:
                      '${formatAvailabilityTime(availabilityStartTime, amLabel: l10n.amLabel, pmLabel: l10n.pmLabel)} '
                      '- ${formatAvailabilityTime(availabilityEndTime, amLabel: l10n.amLabel, pmLabel: l10n.pmLabel)}',
                ),
              ],
            ),
          ),
          const Divider(),
          _Section(
            icon: Icons.location_on_outlined,
            title: l10n.addressSectionTitle,
            child: Text(address, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.icon, required this.title, required this.child});

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: scheme.onSurfaceVariant),
            const SizedBox(width: AppSpace.s),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: AppSpace.m),
        child,
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.s),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
