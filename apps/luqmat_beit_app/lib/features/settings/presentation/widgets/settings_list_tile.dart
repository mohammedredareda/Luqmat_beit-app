import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Shared "إعدادات الحساب" row shape from the settings mockup: leading
/// icon in a tinted circle, title, optional subtitle, trailing chevron.
class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleTextDirection,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final TextDirection? subtitleTextDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l, vertical: AppSpace.xs),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: scheme.surfaceContainerHigh, shape: BoxShape.circle),
        child: Icon(icon, size: 20, color: scheme.onSurfaceVariant),
      ),
      title: Text(title, style: textTheme.bodyLarge),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              textDirection: subtitleTextDirection,
              style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
      trailing: onTap == null
          ? null
          : Icon(Icons.chevron_left, color: scheme.onSurfaceVariant),
    );
  }
}
