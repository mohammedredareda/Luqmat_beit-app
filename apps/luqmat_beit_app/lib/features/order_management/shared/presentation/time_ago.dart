import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// Elapsed time since an order was placed (`my_orders` mockup's
/// "منذ 12 دقيقة" meta row) — distinct from [PendingCountdown]'s
/// time-*remaining*-until-CK-25-timeout, which is a different concept
/// shown only on the Order Details pending view.
String formatTimeAgo(AppLocalizations l10n, DateTime createdAt) {
  final elapsed = DateTime.now().difference(createdAt);
  if (elapsed.inMinutes < 1) return l10n.timeAgoJustNow;
  if (elapsed.inMinutes < 60) return l10n.timeAgoMinutesAgo(elapsed.inMinutes);
  if (elapsed.inHours < 24) return l10n.timeAgoHoursAgo(elapsed.inHours);
  return l10n.timeAgoDaysAgo(elapsed.inDays);
}
