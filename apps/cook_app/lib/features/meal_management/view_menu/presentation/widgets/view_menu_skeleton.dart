import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real My Menu layout (sale-status card + horizontal 96x96
/// meal rows) rather than the mismatched vertical/4:3-image skeleton
/// mockup, so loading and loaded states share one visual shape (R-29).
class ViewMenuSkeleton extends StatelessWidget {
  const ViewMenuSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: const [
        _StatusCardSkeleton(),
        SizedBox(height: AppSpace.xl),
        _MealRowSkeleton(),
        SizedBox(height: AppSpace.m),
        _MealRowSkeleton(),
        SizedBox(height: AppSpace.m),
        _MealRowSkeleton(),
      ],
    );
  }
}

class _StatusCardSkeleton extends StatelessWidget {
  const _StatusCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerBox(width: 100, height: 16, borderRadius: 4),
                SizedBox(height: AppSpace.s),
                ShimmerBox(width: 160, height: 12, borderRadius: 4),
              ],
            ),
          ),
          ShimmerBox(width: 48, height: 28, borderRadius: AppRadius.pill),
        ],
      ),
    );
  }
}

class _MealRowSkeleton extends StatelessWidget {
  const _MealRowSkeleton();

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
          ShimmerBox(width: 96, height: 96, borderRadius: AppRadius.image),
          SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerBox(width: 140, height: 16, borderRadius: 4),
                SizedBox(height: AppSpace.xs),
                ShimmerBox(width: 180, height: 12, borderRadius: 4),
                SizedBox(height: AppSpace.xs),
                ShimmerBox(width: 60, height: 14, borderRadius: 4),
              ],
            ),
          ),
          SizedBox(width: AppSpace.s),
          ShimmerBox(width: 32, height: 32, borderRadius: AppRadius.pill),
        ],
      ),
    );
  }
}
