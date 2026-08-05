import 'package:flutter/material.dart';

/// A field label with a trailing red required-asterisk, matching the
/// `create_discount_with_meal_selection` mockup's "الوجبة *" / "نسبة
/// الخصم (%) *" labels.
class RequiredFieldLabel extends StatelessWidget {
  const RequiredFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant);

    return Text.rich(
      TextSpan(
        text: label,
        style: style,
        children: [
          const TextSpan(text: ' '),
          TextSpan(text: '*', style: style?.copyWith(color: scheme.error)),
        ],
      ),
    );
  }
}
