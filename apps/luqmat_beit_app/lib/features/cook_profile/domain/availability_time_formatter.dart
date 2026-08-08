/// Formats a single `"HH:mm"` 24-hour time string as 12-hour "h:mm ص/م"
/// with Latin numerals — R-15 (hard rule) mandates Latin numerals for
/// times, so this doesn't go through `MaterialLocalizations.formatTimeOfDay`,
/// whose Arabic locale output uses Eastern Arabic-Indic digits by default.
String formatAvailabilityTime(
  String time24, {
  required String amLabel,
  required String pmLabel,
}) {
  final parts = time24.split(':');
  if (parts.length != 2) return time24;
  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  if (hour == null || minute == null) return time24;

  final isPm = hour >= 12;
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;
  final minuteStr = minute.toString().padLeft(2, '0');
  return '$hour12:$minuteStr ${isPm ? pmLabel : amLabel}';
}
