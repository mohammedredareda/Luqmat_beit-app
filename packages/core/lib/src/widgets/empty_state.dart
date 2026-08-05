import 'package:flutter/material.dart';

import '../theme/sumac_theme.dart';

/// Friendly, illustrated empty state (R-29: invitation, not emptiness) —
/// an icon in a tinted circle, a heading, body copy, and an optional
/// full-width primary CTA. Parameterized so every screen's empty state
/// (empty menu, empty orders, empty offers, ...) is one call site rather
/// than a bespoke widget per screen.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.heading,
    required this.body,
    this.ctaLabel,
    this.onCtaPressed,
  });

  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String heading;
  final String body;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpace.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 80, color: iconColor),
          ),
          const SizedBox(height: AppSpace.xl),
          Text(
            heading,
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpace.s),
          Text(
            body,
            style: textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (ctaLabel != null && onCtaPressed != null) ...[
            const SizedBox(height: AppSpace.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCtaPressed,
                child: Text(ctaLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
