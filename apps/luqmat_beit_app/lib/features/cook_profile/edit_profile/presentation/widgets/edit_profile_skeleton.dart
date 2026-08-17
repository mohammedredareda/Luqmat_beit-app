import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Edit Profile form's shape (avatar + name/bio/address
/// fields + location row + day chips + hour pickers) so loading and
/// loaded states share one visual outline (R-29 — skeleton loaders,
/// never a bare spinner). Static chrome (Save/Cancel buttons) isn't
/// skeletoned — only the fields whose content actually depends on the
/// network response.
class EditProfileSkeleton extends StatelessWidget {
  const EditProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        const Center(
          child: LoadingSkeleton(width: 96, height: 96, borderRadius: 48),
        ),
        const SizedBox(height: AppSpace.s),
        const Center(child: LoadingSkeleton(width: 110, height: 14)),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.l),
        const LoadingSkeleton(height: 96, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.l),
        const LoadingSkeleton(height: 72, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.s),
        Row(
          children: const [
            Expanded(child: LoadingSkeleton(height: 52, borderRadius: AppRadius.input)),
            SizedBox(width: AppSpace.s),
            LoadingSkeleton(width: 90, height: 52, borderRadius: AppRadius.input),
          ],
        ),
        const SizedBox(height: AppSpace.l),
        const LoadingSkeleton(width: 100, height: 12),
        const SizedBox(height: AppSpace.s),
        Wrap(
          spacing: AppSpace.s,
          runSpacing: AppSpace.s,
          children: const [
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
            LoadingSkeleton(width: 64, height: 36, borderRadius: AppRadius.badge),
          ],
        ),
        const SizedBox(height: AppSpace.l),
        Row(
          children: const [
            Expanded(child: LoadingSkeleton(height: 56, borderRadius: AppRadius.input)),
            SizedBox(width: AppSpace.m),
            Expanded(child: LoadingSkeleton(height: 56, borderRadius: AppRadius.input)),
          ],
        ),
      ],
    );
  }
}
