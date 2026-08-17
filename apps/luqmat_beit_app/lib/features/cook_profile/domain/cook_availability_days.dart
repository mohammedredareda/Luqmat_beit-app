import 'package:core/core.dart';

/// `PATCH`/`GET /users/profile`'s own confirmed `availability_days`
/// numbering — 1=Sunday…7=Saturday, not ISO-8601 (`Weekday.isoNumber` is
/// `POST /auth/register`'s different convention) — shared between Edit
/// Profile (sends it) and View Profile (displays it).
int weekdayToSundayFirstNumber(Weekday day) => switch (day) {
      Weekday.sun => 1,
      Weekday.mon => 2,
      Weekday.tue => 3,
      Weekday.wed => 4,
      Weekday.thu => 5,
      Weekday.fri => 6,
      Weekday.sat => 7,
    };

/// Inverse of [weekdayToSundayFirstNumber]. Unrecognized numbers are
/// dropped (return null) rather than thrown, since callers use this on
/// server data, not a value the cook can correct.
Weekday? weekdayFromSundayFirstNumber(int number) => switch (number) {
      1 => Weekday.sun,
      2 => Weekday.mon,
      3 => Weekday.tue,
      4 => Weekday.wed,
      5 => Weekday.thu,
      6 => Weekday.fri,
      7 => Weekday.sat,
      _ => null,
    };

/// Converts a raw `availability_days` list (Sunday-first numbers, any
/// order/duplicates) into the [Weekday]s it represents, sorted into
/// [Weekday.values]' own Sat→Fri declaration order for a stable display
/// order matching the day-picker's own chip order.
List<Weekday> weekdaysFromSundayFirstNumbers(List<int> numbers) {
  final days = numbers.map(weekdayFromSundayFirstNumber).whereType<Weekday>().toSet();
  return [for (final day in Weekday.values) if (days.contains(day)) day];
}
