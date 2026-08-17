import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// A discount on a single meal. The real `my-promotions` endpoint returns a
/// pre-rendered [title]/[description] pair (the percentage is already baked
/// into the Arabic title text, e.g. "خصم 16.12% على شاورما دجاج") plus an
/// [imageUrl] — but still no separate meal/price detail (see
/// `OfferFeedItemEntity`'s doc comment). A discount is limited either by
/// time ([expiryTime]) or by [usageRemaining], never necessarily both.
class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
    required this.title,
    required this.description,
    required this.expiryTime,
    this.imageUrl,
    this.usageRemaining,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final String description;
  final DateTime? expiryTime;
  final String? imageUrl;
  final int? usageRemaining;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    final String chip;
    final usageRemaining = this.usageRemaining;
    final expiryTime = this.expiryTime;
    if (usageRemaining != null) {
      chip = usageRemaining <= 0
          ? l10n.offerExpiredLabel
          : l10n.discountUsesRemainingLabel(usageRemaining);
    } else if (expiryTime != null) {
      final remainingDays = expiryTime.difference(DateTime.now()).inDays;
      chip = remainingDays <= 0 ? l10n.offerExpiredLabel : l10n.offerExpiresInLabel(remainingDays);
    } else {
      chip = l10n.offerNoLimitLabel;
    }

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: _PlaceholderHeader(icon: Icons.percent, imageUrl: imageUrl),
      badge: _Badge(
        icon: Icons.percent,
        label: l10n.discountBadgeGenericLabel,
        backgroundColor: scheme.error,
        foregroundColor: scheme.onError,
      ),
      title: title,
      chip: chip,
      description: description,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}

/// A bundle/package offer. Same data shape as [DiscountCard] minus
/// [usageRemaining] — offers are never usage-limited.
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.expiryTime,
    this.imageUrl,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final String description;
  final DateTime? expiryTime;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final expiryTime = this.expiryTime;
    final String chip;
    if (expiryTime != null) {
      final remainingDays = expiryTime.difference(DateTime.now()).inDays;
      chip = remainingDays <= 0 ? l10n.offerExpiredLabel : l10n.offerExpiresInLabel(remainingDays);
    } else {
      chip = l10n.offerNoLimitLabel;
    }

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: _PlaceholderHeader(icon: Icons.restaurant, imageUrl: imageUrl),
      badge: _Badge(
        icon: Icons.sell,
        label: l10n.offerBadgeLabel,
        backgroundColor: AppColors.zaatar,
        foregroundColor: scheme.onSecondary,
      ),
      title: title,
      chip: chip,
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

/// Shows the real photo when [imageUrl] is available, falling back to a
/// gradient+icon placeholder when it's missing or fails to load.
class _PlaceholderHeader extends StatelessWidget {
  const _PlaceholderHeader({required this.icon, this.imageUrl});

  final IconData icon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl;
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: imageUrl == null
          ? _placeholder()
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    return Container(
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
