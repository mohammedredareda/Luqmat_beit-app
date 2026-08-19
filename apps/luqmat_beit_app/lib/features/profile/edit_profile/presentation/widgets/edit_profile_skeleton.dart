import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Edit Profile form's shape (avatar + name/address
/// fields + location row) so loading and loaded states share one visual
/// outline (R-29 — skeleton loaders, never a bare spinner). Adapted from
/// the cook module's `EditProfileSkeleton` minus the bio/availability rows
/// this smaller customer form doesn't have.
class EditProfileSkeleton extends StatelessWidget {
  const EditProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        const Center(
          child: LoadingSkeleton(width: 112, height: 112, borderRadius: 56),
        ),
        const SizedBox(height: AppSpace.s),
        const Center(child: LoadingSkeleton(width: 110, height: 14)),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.l),
        const LoadingSkeleton(height: 96, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.s),
        Row(
          children: const [
            Expanded(child: LoadingSkeleton(height: 52, borderRadius: AppRadius.input)),
            SizedBox(width: AppSpace.s),
            LoadingSkeleton(width: 90, height: 52, borderRadius: AppRadius.input),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.input),
      ],
    );
  }
}
