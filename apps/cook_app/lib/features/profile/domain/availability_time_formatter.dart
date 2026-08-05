import 'package:core/core.dart';

/// Formats an [AvailabilityTime] as 12-hour "h:mm ص/م" with Latin numerals
/// — R-15 (hard rule) mandates Latin numerals for times, so this doesn't go
/// through `MaterialLocalizations.formatTimeOfDay`, whose Arabic locale
/// output uses Eastern Arabic-Indic digits by default.
String formatAvailabilityTime(
  AvailabilityTime time, {
  required String amLabel,
  required String pmLabel,
}) {
  final isPm = time.hour >= 12;
  final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minuteStr = time.minute.toString().padLeft(2, '0');
  return '$hour12:$minuteStr ${isPm ? pmLabel : amLabel}';
}
