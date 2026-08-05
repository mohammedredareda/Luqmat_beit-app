import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Profile layout (avatar/name/rating + 3 stat tiles +
/// one details card) so loading and loaded states share one visual shape
/// (R-29 — skeleton loaders, never a bare spinner).
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: [
        const Center(
          child: ShimmerBox(width: 128, height: 128, borderRadius: 64),
        ),
        const SizedBox(height: AppSpace.l),
        const Center(child: ShimmerBox(width: 140, height: 22, borderRadius: 4)),
        const SizedBox(height: AppSpace.s),
        const Center(child: ShimmerBox(width: 100, height: 14, borderRadius: 4)),
        const SizedBox(height: AppSpace.xl),
        Row(
          children: const [
            Expanded(child: ShimmerBox(width: double.infinity, height: 88, borderRadius: AppRadius.card)),
            SizedBox(width: AppSpace.m),
            Expanded(child: ShimmerBox(width: double.infinity, height: 88, borderRadius: AppRadius.card)),
            SizedBox(width: AppSpace.m),
            Expanded(child: ShimmerBox(width: double.infinity, height: 88, borderRadius: AppRadius.card)),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        const ShimmerBox(width: double.infinity, height: 260, borderRadius: AppRadius.card),
      ],
    );
  }
}
