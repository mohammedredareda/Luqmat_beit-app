import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Edit Discount form's shape (target-meal row, percentage
/// field, price-after rows, restriction toggle) so loading and loaded
/// states share one visual outline (R-29 — skeleton loaders, never a bare
/// spinner).
class EditDiscountSkeleton extends StatelessWidget {
  const EditDiscountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        const LoadingSkeleton(width: 220, height: 12),
        const SizedBox(height: AppSpace.xl),
        Container(
          padding: AppSpace.cardPadding,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.surfaceContainerHighest),
          ),
          child: Row(
            children: [
              const LoadingSkeleton(width: 64, height: 64, borderRadius: AppRadius.image),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    LoadingSkeleton(width: 80, height: 10),
                    SizedBox(height: AppSpace.xs),
                    LoadingSkeleton(width: 140, height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(width: 120, height: 14),
        const SizedBox(height: AppSpace.s),
        const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(width: 160, height: 14),
        const SizedBox(height: AppSpace.m),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.s),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.xl),
        Divider(color: scheme.outlineVariant),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(width: 100, height: 14),
        const SizedBox(height: AppSpace.m),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.pill),
        const SizedBox(height: AppSpace.m),
        Row(
          children: const [
            Expanded(child: LoadingSkeleton(height: 48, borderRadius: AppRadius.input)),
            SizedBox(width: AppSpace.m),
            Expanded(child: LoadingSkeleton(height: 48, borderRadius: AppRadius.input)),
          ],
        ),
      ],
    );
  }
}
