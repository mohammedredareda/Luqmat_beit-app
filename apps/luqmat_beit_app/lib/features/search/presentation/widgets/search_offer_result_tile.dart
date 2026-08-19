import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Row-style bundle-offer result in the Search list — taps through to
/// `OfferDetailsPage` at `/offer/:offerId` (features/offer_details).
class SearchOfferResultTile extends StatelessWidget {
  const SearchOfferResultTile({
    super.key,
    required this.offer,
    required this.currencySuffix,
    required this.onTap,
  });

  final OfferBundleEntity offer;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final coverImageUrl =
        offer.meals.isNotEmpty ? offer.meals.first.imageUrl : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: SizedBox(
                width: 72,
                height: 72,
                child: coverImageUrl.isEmpty
                    ? Container(color: scheme.surfaceContainerHighest)
                    : Image.network(coverImageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    '${offer.meals.length} وجبات',
                    style: textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    '${offer.totalPrice.toStringAsFixed(0)} $currencySuffix',
                    style: textTheme.titleSmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
