import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One notification row from the mockup: a type-colored icon avatar, an
/// unread dot (R-29 style visual distinction rather than relying on color
/// alone), title/timestamp row, and body text.
class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationEntity notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isUnread = !notification.isRead;
    final style = _iconStyleFor(notification.type);

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isUnread ? 1 : 0.7,
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpace.m),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outline),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: style.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(style.icon, color: style.foreground),
                  ),
                  const SizedBox(width: AppSpace.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isUnread
                                      ? scheme.onSurface
                                      : scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpace.s),
                            Text(
                              _relativeTime(notification.createdAt),
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpace.xs),
                        Text(
                          notification.body,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isUnread)
                PositionedDirectional(
                  end: -2,
                  top: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.sumac,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconStyle {
  const _IconStyle(this.icon, this.background, this.foreground);

  final IconData icon;
  final Color background;
  final Color foreground;
}

_IconStyle _iconStyleFor(NotificationType type) {
  switch (type) {
    case NotificationType.orderStatus:
      return const _IconStyle(
        Icons.inventory_2_outlined,
        AppColors.zaatarContainer,
        AppColors.onZaatarContainer,
      );
    case NotificationType.offer:
      return const _IconStyle(
        Icons.sell_outlined,
        AppColors.surfaceVariantLight,
        AppColors.inkMutedLight,
      );
    case NotificationType.system:
      return const _IconStyle(
        Icons.info_outline,
        AppColors.errorContainer,
        AppColors.error,
      );
  }
}

String _relativeTime(DateTime createdAt) {
  final diff = DateTime.now().difference(createdAt);
  if (diff.inMinutes < 1) return 'الآن';
  if (diff.inHours < 1) return 'منذ ${diff.inMinutes} دقيقة';
  if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
  if (diff.inDays == 1) return 'أمس';
  return 'منذ ${diff.inDays} يوم';
}
