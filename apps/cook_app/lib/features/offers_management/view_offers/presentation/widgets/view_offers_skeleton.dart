import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Offers list layout (rounded cards with a thumbnail +
/// title/subtitle/price), composed from `ShimmerBox` like
/// `ViewMenuSkeleton`, so loading and loaded states share one visual
/// shape (R-29).
class ViewOffersSkeleton extends StatelessWidget {
  const ViewOffersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: const [
        _OfferCardSkeleton(),
        SizedBox(height: AppSpace.m),
        _OfferCardSkeleton(),
        SizedBox(height: AppSpace.m),
        _OfferCardSkeleton(),
      ],
    );
  }
}

class _OfferCardSkeleton extends StatelessWidget {
  const _OfferCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.m),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: const Row(
        children: [
          ShimmerBox(width: 72, height: 72, borderRadius: AppRadius.image),
          SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerBox(width: 140, height: 16, borderRadius: 4),
                SizedBox(height: AppSpace.xs),
                ShimmerBox(width: 100, height: 12, borderRadius: 4),
                SizedBox(height: AppSpace.s),
                ShimmerBox(width: 60, height: 16, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
