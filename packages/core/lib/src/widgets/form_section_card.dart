import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Generic bordered/titled wrapper for a group of form fields — reused
/// across every multi-section create/edit form (meals, offers, discounts).
class FormSectionCard extends StatelessWidget {
  const FormSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpace.m),
          ...children,
        ],
      ),
    );
  }
}
