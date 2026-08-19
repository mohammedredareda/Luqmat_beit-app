import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Profile layout (avatar/name + 2 stat tiles + one
/// address card) so loading and loaded states share one visual shape
/// (R-29 — skeleton loaders, never a bare spinner). Adapted from the cook
/// module's `ProfileSkeleton` minus the rating-line skeleton.
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: [
        const Center(
          child: LoadingSkeleton(width: 128, height: 128, borderRadius: 64),
        ),
        const SizedBox(height: AppSpace.l),
        const Center(child: LoadingSkeleton(width: 140, height: 22)),
        const SizedBox(height: AppSpace.xl),
        Row(
          children: const [
            Expanded(child: LoadingSkeleton(height: 88, borderRadius: AppRadius.card)),
            SizedBox(width: AppSpace.m),
            Expanded(child: LoadingSkeleton(height: 88, borderRadius: AppRadius.card)),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(height: 120, borderRadius: AppRadius.card),
      ],
    );
  }
}
