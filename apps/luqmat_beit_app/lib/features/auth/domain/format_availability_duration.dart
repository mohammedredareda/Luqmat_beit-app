import 'package:flutter/material.dart';

/// `Weekday`/`WeekdayLabel`/`weekdayRangeToIsoDays` moved to
/// `package:core` (`cook_profile`'s Edit Profile screen needs them too,
/// and they're pure Dart with no Flutter dependency) — re-exported here so
/// every existing import of this file keeps working unchanged.
export 'package:core/core.dart' show Weekday, WeekdayLabel, weekdayRangeToIsoDays;

/// CK-01's registration screen captures availability as a day-range +
/// time-range. The real `POST /auth/register` request wants
/// `startAvailabilityTime`/`endAvailabilityTime` as full ISO datetimes —
/// only the time-of-day is meaningful here, so [time] is anchored to a
/// fixed, arbitrary UTC date. Callers send this on with
/// `.toIso8601String()`.
DateTime timeOfDayToDateTime(TimeOfDay time) {
  return DateTime.utc(2024, 1, 1, time.hour, time.minute);
}
