/// A day of the week, Sunday-first (matches the Arabic-locale week used
/// throughout this app). Part of [CookProfileEntity]'s availability shape.
enum Weekday {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday;

  /// Stable wire/JSON identifier — independent of enum declaration order.
  String get id => switch (this) {
        Weekday.sunday => 'sunday',
        Weekday.monday => 'monday',
        Weekday.tuesday => 'tuesday',
        Weekday.wednesday => 'wednesday',
        Weekday.thursday => 'thursday',
        Weekday.friday => 'friday',
        Weekday.saturday => 'saturday',
      };

  static Weekday? fromId(String id) {
    for (final day in Weekday.values) {
      if (day.id == id) return day;
    }
    return null;
  }
}
