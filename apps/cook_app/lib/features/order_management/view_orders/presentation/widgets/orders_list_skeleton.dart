import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton shaped like [OrderCard] (R-29: skeleton, not spinner).
class OrdersListSkeleton extends StatelessWidget {
  const OrdersListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: const [
        _OrderCardSkeleton(),
        SizedBox(height: AppSpace.m),
        _OrderCardSkeleton(),
        SizedBox(height: AppSpace.m),
        _OrderCardSkeleton(),
      ],
    );
  }
}

class _OrderCardSkeleton extends StatelessWidget {
  const _OrderCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.m),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(width: 40, height: 40, borderRadius: AppRadius.pill),
              SizedBox(width: AppSpace.m),
              Expanded(child: ShimmerBox(width: double.infinity, height: 16, borderRadius: 4)),
              SizedBox(width: AppSpace.s),
              ShimmerBox(width: 64, height: 24, borderRadius: AppRadius.pill),
            ],
          ),
          SizedBox(height: AppSpace.m),
          ShimmerBox(width: 180, height: 14, borderRadius: 4),
          SizedBox(height: AppSpace.xs),
          ShimmerBox(width: 140, height: 14, borderRadius: 4),
          SizedBox(height: AppSpace.m),
          Row(
            children: [
              ShimmerBox(width: 60, height: 20, borderRadius: 4),
              Spacer(),
              ShimmerBox(width: 80, height: 36, borderRadius: AppRadius.button),
              SizedBox(width: AppSpace.s),
              ShimmerBox(width: 100, height: 36, borderRadius: AppRadius.button),
            ],
          ),
        ],
      ),
    );
  }
}
