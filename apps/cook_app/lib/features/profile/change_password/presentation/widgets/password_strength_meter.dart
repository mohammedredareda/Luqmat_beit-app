import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../domain/password_validator.dart';

/// The change-password mockup's 4-bar strength meter + label, driven
/// purely by the current new-password text — no bloc involvement, it's
/// derived UI feedback, not submitted state.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final strength = scorePasswordStrength(password);

    final (filledBars, barColor, label, labelColor) = switch (strength) {
      PasswordStrength.empty => (0, scheme.surfaceContainerHighest, l10n.passwordStrengthHint, scheme.onSurfaceVariant),
      PasswordStrength.weak => (1, scheme.error, l10n.passwordStrengthWeak, scheme.error),
      PasswordStrength.medium => (2, scheme.tertiary, l10n.passwordStrengthMedium, scheme.tertiary),
      PasswordStrength.good => (3, scheme.secondary, l10n.passwordStrengthGood, scheme.secondary),
      PasswordStrength.veryStrong => (
          4,
          scheme.onSecondaryContainer,
          l10n.passwordStrengthVeryStrong,
          scheme.onSecondaryContainer,
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            final filled = index < filledBars;
            return Expanded(
              child: Container(
                margin: EdgeInsetsDirectional.only(end: index < 3 ? AppSpace.xs : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: filled ? barColor : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: labelColor)),
      ],
    );
  }
}
