import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

enum OfferTypeChoice { offer, discount }

/// R-28: quick binary choice → Bottom Sheet, not a Dialog.
Future<OfferTypeChoice?> showSelectOfferTypeSheet(BuildContext context) {
  return showModalBottomSheet<OfferTypeChoice>(
    context: context,
    builder: (_) => const _SelectOfferTypeSheet(),
  );
}

class _SelectOfferTypeSheet extends StatelessWidget {
  const _SelectOfferTypeSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.s, AppSpace.l, AppSpace.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.selectOfferTypeSheetTitle, style: textTheme.titleMedium),
            const SizedBox(height: AppSpace.l),
            _OfferTypeRow(
              icon: Icons.local_offer_outlined,
              iconBackgroundColor: AppColors.sumacContainer,
              iconColor: scheme.primary,
              title: l10n.createOfferOptionTitle,
              body: l10n.createOfferOptionBody,
              onTap: () => Navigator.of(context).pop(OfferTypeChoice.offer),
            ),
            const SizedBox(height: AppSpace.m),
            _OfferTypeRow(
              icon: Icons.percent,
              iconBackgroundColor: AppColors.sumacContainer,
              iconColor: scheme.primary,
              title: l10n.createDiscountOptionTitle,
              body: l10n.createDiscountOptionBody,
              onTap: () => Navigator.of(context).pop(OfferTypeChoice.discount),
            ),
            const SizedBox(height: AppSpace.m),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancelLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferTypeRow extends StatelessWidget {
  const _OfferTypeRow({
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpace.l),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: iconBackgroundColor, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: AppSpace.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: textTheme.titleMedium),
                    const SizedBox(height: AppSpace.xs),
                    Text(body, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
