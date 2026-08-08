import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../domain/availability_time_formatter.dart';

/// Single availability window editor — two tap-to-pick time fields backed
/// by the native `showTimePicker`. The backlog confirms a cook's
/// `availabilityTime` is one time window, not a per-weekday schedule.
class AvailabilityEditor extends StatelessWidget {
  const AvailabilityEditor({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    this.hoursErrorText,
  });

  final String startTime;
  final String endTime;
  final ValueChanged<String> onStartTimeChanged;
  final ValueChanged<String> onEndTimeChanged;
  final String? hoursErrorText;

  TimeOfDay _parse(String time24) {
    final parts = time24.split(':');
    if (parts.length != 2) return const TimeOfDay(hour: 9, minute: 0);
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }

  String _format(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  Future<void> _pickTime(
    BuildContext context,
    String current,
    ValueChanged<String> onChanged,
  ) async {
    final picked = await showTimePicker(context: context, initialTime: _parse(current));
    if (picked != null) onChanged(_format(picked));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
