import 'package:flutter/material.dart';

import '../theme/sumac_theme.dart';

/// The bordered, titled card shell used by create/edit forms and detail
/// screens across features (matches `SaleStatusCard`'s decoration).
class FormSectionCard extends StatelessWidget {
  const FormSectionCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpace.m),
          ...children,
        ],
      ),
    );
  }
}
