/// Shared day-of-week vocabulary for availability windows (cook
/// registration and profile editing both use this) — declared in Sat…Fri
/// order (the Arabic work-week convention both flows' day-range pickers
/// cycle through), not calendar/ISO order.
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

  /// ISO-8601 weekday number (1=Monday…7=Sunday) — the numbering the real
  /// API's `availability_days` expects, confirmed from a live example
  /// (`[1, 2, 3, 4, 5]` for a Mon–Fri range).
  int get isoNumber => switch (this) {
        Weekday.mon => 1,
        Weekday.tue => 2,
        Weekday.wed => 3,
        Weekday.thu => 4,
        Weekday.fri => 5,
        Weekday.sat => 6,
        Weekday.sun => 7,
      };
}

/// Expands a day range into ISO weekday numbers, walking [Weekday]'s own
/// declared Sat→Fri order so a "Sat–Wed" range correctly wraps as
/// [sat, sun, mon, tue, wed], not empty.
List<int> weekdayRangeToIsoDays({required Weekday startDay, required Weekday endDay}) {
  final days = <int>[];
  var index = startDay.index;
  while (true) {
    days.add(Weekday.values[index].isoNumber);
    if (index == endDay.index) break;
    index = (index + 1) % Weekday.values.length;
  }
  return days;
}
