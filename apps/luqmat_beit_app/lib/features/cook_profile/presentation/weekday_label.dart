import 'package:core/core.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// Shared between Edit Profile's day picker and View Profile's read-only
/// display, so both show identical wording for the same [Weekday].
String weekdayLabel(AppLocalizations l10n, Weekday day) => switch (day) {
      Weekday.sat => l10n.weekdaySaturday,
      Weekday.sun => l10n.weekdaySunday,
      Weekday.mon => l10n.weekdayMonday,
      Weekday.tue => l10n.weekdayTuesday,
      Weekday.wed => l10n.weekdayWednesday,
      Weekday.thu => l10n.weekdayThursday,
      Weekday.fri => l10n.weekdayFriday,
    };
