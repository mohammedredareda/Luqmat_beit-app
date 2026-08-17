import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// A discount on a single meal. The real `my-promotions` endpoint only
/// returns a pre-rendered [title]/[description] pair (the percentage is
/// already baked into the Arabic title text, e.g. "خصم 16.12% على شاورما
/// دجاج") and no meal image/price — this card is deliberately simpler than
/// the original mockup's photo-and-price layout for that reason (see
/// `OfferFeedItemEntity`'s doc comment).
class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
    required this.title,
    required this.description,
    required this.expiryTime,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final String description;
  final DateTime expiryTime;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final remainingDays = expiryTime.difference(DateTime.now()).inDays;
    final expired = remainingDays <= 0;

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: const _PlaceholderHeader(icon: Icons.percent),
      badge: _Badge(
        icon: Icons.percent,
        label: l10n.discountBadgeGenericLabel,
        backgroundColor: scheme.error,
        foregroundColor: scheme.onError,
      ),
      title: title,
      chip: expired ? l10n.offerExpiredLabel : l10n.offerExpiresInLabel(remainingDays),
      description: description,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}

/// A bundle/package offer. Same data limitation as [DiscountCard] — no
/// photo or price is available from the real feed endpoint.
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.expiryTime,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final String description;
  final DateTime expiryTime;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final remainingDays = expiryTime.difference(DateTime.now()).inDays;
    final expired = remainingDays <= 0;

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: const _PlaceholderHeader(icon: Icons.restaurant),
      badge: _Badge(
        icon: Icons.sell,
        label: l10n.offerBadgeLabel,
        backgroundColor: AppColors.zaatar,
        foregroundColor: scheme.onSecondary,
      ),
      title: title,
      chip: expired ? l10n.offerExpiredLabel : l10n.offerExpiresInLabel(remainingDays),
      description: description,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.m, vertical: AppSpace.xs),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.badge),
        boxShadow: AppShadow.e1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: AppSpace.xs),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: foregroundColor),
          ),
        ],
      ),
    );
  }
}

/// TODO(backend): swap for a real photo header if/when a per-item detail
/// endpoint returns one — `my-promotions` has no image field for either
/// offers or discounts today.
class _PlaceholderHeader extends StatelessWidget {
  const _PlaceholderHeader({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.zaatarContainer, AppColors.surfaceVariantLight],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 48, color: AppColors.zaatar.withValues(alpha: 0.3)),
    );
  }
}

/// Shared card shell both [OfferCard] and [DiscountCard] render through —
/// full-width placeholder header with a top-start badge, then
/// title/expiry-chip row, description line, and both an Edit and an
/// error-colored outlined Delete icon button (CK-11 requires both).
class _OfferDiscountCardShell extends StatelessWidget {
  const _OfferDiscountCardShell({
    required this.header,
    required this.badge,
    required this.title,
    required this.chip,
    required this.description,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Widget header;
  final Widget badge;
  final String title;
  final String chip;
  final String description;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: scheme.outlineVariant)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  header,
                  PositionedDirectional(top: AppSpace.m, start: AppSpace.m, child: badge),
                ],
              ),
              Padding(
                padding: AppSpace.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpace.s),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpace.s,
                            vertical: AppSpace.xs,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            chip,
                            style: textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: AppSpace.s),
                      Text(
                        description,
                        style: textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpace.m),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: onEdit,
                            icon: const Icon(Icons.edit_outlined),
                            color: scheme.onSurfaceVariant,
                            style: IconButton.styleFrom(
                              backgroundColor: scheme.surfaceContainerHighest,
                              shape: const CircleBorder(),
                            ),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(width: AppSpace.s),
                          IconButton(
                            onPressed: onDelete,
                            icon: const Icon(Icons.delete_outline),
                            color: scheme.error,
                            style: IconButton.styleFrom(
                              backgroundColor: scheme.errorContainer,
                              shape: const CircleBorder(),
                            ),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
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
