import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/circle_badge.dart';

/// One of the 3 onboarding slides — an icon-in-circle badge (standing in
/// for a real illustration, none exists yet), a title, and a description.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: AppSpace.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleBadge(size: 256, child: Icon(icon, size: 96, color: scheme.primary)),
          const SizedBox(height: AppSpace.xxl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(color: scheme.primary),
          ),
          const SizedBox(height: AppSpace.m),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
