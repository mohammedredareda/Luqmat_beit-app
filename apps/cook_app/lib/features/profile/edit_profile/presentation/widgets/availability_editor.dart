import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../domain/availability_time_formatter.dart';
import '../../../presentation/weekday_label.dart';

/// Structured availability editor — a `FilterChip` per weekday (R-23:
/// multi-choice = FilterChips) plus two tap-to-pick time fields backed by
/// the native `showTimePicker`, replacing the earlier two free-text
/// fields.
class AvailabilityEditor extends StatelessWidget {
  const AvailabilityEditor({
    super.key,
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
    required this.onDayToggled,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    this.daysErrorText,
    this.hoursErrorText,
  });

  final Set<Weekday> selectedDays;
  final AvailabilityTime startTime;
  final AvailabilityTime endTime;
  final ValueChanged<Weekday> onDayToggled;
  final ValueChanged<AvailabilityTime> onStartTimeChanged;
  final ValueChanged<AvailabilityTime> onEndTimeChanged;
  final String? daysErrorText;
  final String? hoursErrorText;

  Future<void> _pickTime(
    BuildContext context,
    AvailabilityTime current,
    ValueChanged<AvailabilityTime> onChanged,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
    );
    if (picked != null) onChanged(AvailabilityTime(hour: picked.hour, minute: picked.minute));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.availabilityDaysFieldLabel, style: textTheme.bodySmall),
        const SizedBox(height: AppSpace.s),
        Wrap(
          spacing: AppSpace.s,
          runSpacing: AppSpace.s,
          children: [
            for (final day in Weekday.values)
              FilterChip(
                label: Text(weekdayLabel(l10n, day)),
                selected: selectedDays.contains(day),
                onSelected: (_) => onDayToggled(day),
              ),
          ],
        ),
        if (daysErrorText != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(daysErrorText!, style: textTheme.bodySmall?.copyWith(color: scheme.error)),
        ],
        const SizedBox(height: AppSpace.l),
        Text(l10n.availabilityHoursFieldLabel, style: textTheme.bodySmall),
        const SizedBox(height: AppSpace.s),
        Row(
          children: [
            Expanded(
              child: _TimeField(
                label: l10n.availabilityFromLabel,
                valueText: formatAvailabilityTime(startTime, amLabel: l10n.amLabel, pmLabel: l10n.pmLabel),
                hasError: hoursErrorText != null,
                onTap: () => _pickTime(context, startTime, onStartTimeChanged),
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: _TimeField(
                label: l10n.availabilityToLabel,
                valueText: formatAvailabilityTime(endTime, amLabel: l10n.amLabel, pmLabel: l10n.pmLabel),
                hasError: hoursErrorText != null,
                onTap: () => _pickTime(context, endTime, onEndTimeChanged),
              ),
            ),
          ],
        ),
        if (hoursErrorText != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(hoursErrorText!, style: textTheme.bodySmall?.copyWith(color: scheme.error)),
        ],
      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.valueText,
    required this.hasError,
    required this.onTap,
  });

  final String label;
  final String valueText;
  final bool hasError;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.m),
        decoration: BoxDecoration(
          border: Border.all(color: hasError ? scheme.error : scheme.outline, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.input),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodySmall),
                  Text(valueText, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Icon(Icons.schedule_outlined, size: 18, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
