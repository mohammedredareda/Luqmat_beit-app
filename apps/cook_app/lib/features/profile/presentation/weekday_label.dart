import 'package:core/core.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

/// Maps [Weekday] to its localized label — shared by `view_profile` (day
/// pills) and `edit_profile` (day-selection chips), same reasoning as
/// `edit_meal_page.dart`'s own `_categoryLabel` helper.
String weekdayLabel(AppLocalizations l10n, Weekday day) => switch (day) {
      Weekday.sunday => l10n.weekdaySunday,
      Weekday.monday => l10n.weekdayMonday,
      Weekday.tuesday => l10n.weekdayTuesday,
      Weekday.wednesday => l10n.weekdayWednesday,
      Weekday.thursday => l10n.weekdayThursday,
      Weekday.friday => l10n.weekdayFriday,
      Weekday.saturday => l10n.weekdaySaturday,
    };
