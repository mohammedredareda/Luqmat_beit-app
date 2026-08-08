import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// CK-01's registration screen captures availability as a day-range +
/// time-range (richer UX than a single free-text box), but the backend's
/// `avalability_duration` field only has room for one string with no
/// structured day column — so the day-range is embedded as text in the
/// same string. The field is read/displayed verbatim by the backend, never
/// parsed, so this is safe.
enum Weekday { sat, sun, mon, tue, wed, thu, fri }

extension WeekdayLabel on Weekday {
  String get arabicLabel => switch (this) {
        Weekday.sat => 'السبت',
        Weekday.sun => 'الأحد',
        Weekday.mon => 'الإثنين',
        Weekday.tue => 'الثلاثاء',
        Weekday.wed => 'الأربعاء',
        Weekday.thu => 'الخميس',
        Weekday.fri => 'الجمعة',
      };

  String get englishAbbreviation => switch (this) {
        Weekday.sat => 'Sat',
        Weekday.sun => 'Sun',
        Weekday.mon => 'Mon',
        Weekday.tue => 'Tue',
        Weekday.wed => 'Wed',
        Weekday.thu => 'Thu',
        Weekday.fri => 'Fri',
      };
}

String _formatTime(TimeOfDay time) {
  final asDateTime = DateTime(2024, 1, 1, time.hour, time.minute);
  return DateFormat('hh:mm a').format(asDateTime);
}

/// Joins a day-range + time-range into the single string the backend's
/// `avalability_duration` field expects, e.g. `"Sat-Thu, 10:00 AM - 08:00 PM"`
/// — matches the confirmed API example's time formatting exactly.
String formatAvailabilityDuration({
  required Weekday startDay,
  required Weekday endDay,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
}) {
  return '${startDay.englishAbbreviation}-${endDay.englishAbbreviation}, '
      '${_formatTime(startTime)} - ${_formatTime(endTime)}';
}
