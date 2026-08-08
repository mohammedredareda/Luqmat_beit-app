import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// A discount on a single meal — full-width photo header with a red
/// "٪N خصم" badge, mirroring the `offers_discounts` mockup's card exactly:
/// image → title/expiry-chip row → old/new price + edit/delete actions.
class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
    required this.discount,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final DiscountEntity discount;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final remainingDays = discount.expiryTime.difference(DateTime.now()).inDays;
    final remainingUsage =
        discount.usageNumberLimit == null ? null : discount.usageNumberLimit! - discount.usageCount;
    final expired = remainingDays <= 0 || (remainingUsage != null && remainingUsage <= 0);

    final subtitle = expired
        ? l10n.offerExpiredLabel
        : l10n.offerExpiresInLabel(remainingDays);

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: _PhotoHeader(imageUrl: mealImageUrl),
      // NOTE(R-13): rule says the discount badge is sumac-colored at
      // top-left; the mockup renders it error-red at physical top-right
      // (`top-md right-md`) — followed as mocked (`start` under our
      // RTL-default app renders at the same physical top-right spot).
      badge: _Badge(
        icon: Icons.percent,
        label: l10n.discountBadgeLabel(discount.discountPercentage.toStringAsFixed(0)),
        backgroundColor: scheme.error,
        foregroundColor: scheme.onError,
      ),
      title: mealName,
      chip: subtitle,
      priceRow: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(mealBasePrice.toStringAsFixed(0), style: AppText.priceOld(context)),
          const SizedBox(width: AppSpace.xs),
          Text(discount.apply(mealBasePrice).toStringAsFixed(0), style: AppText.price(context)),
        ],
      ),
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}

/// A bundle/package offer — mirrors the mockup's "bundle" card: the cook's
/// own uploaded bundle photo when set, else a stylized zaatar-tinted
/// placeholder (a bundle has no single representative meal to fall back
/// on), a green "عرض باقة" badge, an ingredient-style summary line, and a
/// single price (no struck-through price).
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    this.imageUrl,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final OfferEntity offer;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final remainingDays = offer.expiryTime.difference(DateTime.now()).inDays;
    final expired = remainingDays <= 0;

    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return _OfferDiscountCardShell(
      onTap: onTap,
      header: hasImage ? _PhotoHeader(imageUrl: imageUrl!) : const _BundlePlaceholderHeader(),
      badge: _Badge(
        icon: Icons.sell,
        label: l10n.offerBadgeLabel,
        backgroundColor: AppColors.zaatar,
        foregroundColor: scheme.onSecondary,
      ),
      title: offer.name,
      chip: expired ? l10n.offerExpiredLabel : l10n.offerExpiresInLabel(remainingDays),
      description: [
        for (final meal in offer.meals) '${meal.variationQuantity} ${meal.mealName}',
      ].join(' + '),
      priceRow: Text(offer.totalPrice.toStringAsFixed(0), style: AppText.price(context)),
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

class _PhotoHeader extends StatelessWidget {
  const _PhotoHeader({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 128,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: scheme.surfaceContainerHighest,
              child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BundlePlaceholderHeader extends StatelessWidget {
  const _BundlePlaceholderHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.zaatarContainer, AppColors.surfaceVariantLight],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.restaurant, size: 64, color: AppColors.zaatar.withValues(alpha: 0.3)),
    );
  }
}

/// Shared card shell both [OfferCard] and [DiscountCard] render through —
/// full-width photo/placeholder header with a top-start badge, then
/// title/expiry-chip row, optional description line, a price row, and
/// both an Edit and an error-colored outlined Delete icon button (CK-11
/// requires both; the mockup's cards only show Edit).
class _OfferDiscountCardShell extends StatelessWidget {
  const _OfferDiscountCardShell({
    required this.header,
    required this.badge,
    required this.title,
    required this.chip,
    required this.priceRow,
    this.description,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Widget header;
  final Widget badge;
  final String title;
  final String chip;
  final Widget priceRow;
  final String? description;
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
                    if (description != null && description!.isNotEmpty) ...[
                      const SizedBox(height: AppSpace.s),
                      Text(
                        description!,
                        style: textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpace.m),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: priceRow),
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
