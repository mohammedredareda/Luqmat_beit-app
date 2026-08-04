import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton shaped like the order-details header/items/summary
/// layout (R-29: skeleton, not spinner).
class OrderDetailsSkeleton extends StatelessWidget {
  const OrderDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: const [
        ShimmerBox(width: double.infinity, height: 96, borderRadius: AppRadius.card),
        SizedBox(height: AppSpace.m),
        ShimmerBox(width: double.infinity, height: 72, borderRadius: AppRadius.card),
        SizedBox(height: AppSpace.m),
        ShimmerBox(width: double.infinity, height: 160, borderRadius: AppRadius.card),
        SizedBox(height: AppSpace.m),
        ShimmerBox(width: double.infinity, height: 120, borderRadius: AppRadius.card),
      ],
    );
  }
}
