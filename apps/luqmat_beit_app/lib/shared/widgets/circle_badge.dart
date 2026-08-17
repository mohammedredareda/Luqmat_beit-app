import 'package:flutter/material.dart';

/// The circular sumac-container badge behind the splash logo and each
/// onboarding slide's icon — shared so both use the exact same treatment.
class CircleBadge extends StatelessWidget {
  const CircleBadge({super.key, required this.size, required this.child});

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: scheme.primaryContainer),
      alignment: Alignment.center,
      child: child,
    );
  }
}
