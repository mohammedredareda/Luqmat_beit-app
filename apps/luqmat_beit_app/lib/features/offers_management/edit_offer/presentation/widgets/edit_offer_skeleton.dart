import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Mirrors the real Edit Offer form's shape (image + name/description card,
/// included-meals card, price/duration card, status card) so loading and
/// loaded states share one visual outline (R-29 — skeleton loaders, never a
/// bare spinner).
class EditOfferSkeleton extends StatelessWidget {
  const EditOfferSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget card(List<Widget> children) => Container(
          padding: AppSpace.cardPadding,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        card([
          const LoadingSkeleton(height: 140, borderRadius: AppRadius.input),
          const SizedBox(height: AppSpace.m),
          const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
          const SizedBox(height: AppSpace.m),
          const LoadingSkeleton(height: 88, borderRadius: AppRadius.input),
        ]),
        const SizedBox(height: AppSpace.xl),
        card([
          const LoadingSkeleton(width: 140, height: 12),
          const SizedBox(height: AppSpace.m),
          for (final _ in [0, 1]) ...[
            Row(
              children: const [
                LoadingSkeleton(width: 48, height: 48, borderRadius: AppRadius.image),
                SizedBox(width: AppSpace.s),
                Expanded(child: LoadingSkeleton(height: 16)),
              ],
            ),
            const SizedBox(height: AppSpace.s),
          ],
          const LoadingSkeleton(height: 40, borderRadius: AppRadius.input),
        ]),
        const SizedBox(height: AppSpace.xl),
        card([
          const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
          const SizedBox(height: AppSpace.m),
          const LoadingSkeleton(height: 56, borderRadius: AppRadius.input),
        ]),
        const SizedBox(height: AppSpace.xl),
        card([const LoadingSkeleton(height: 24, borderRadius: AppRadius.input)]),
        const SizedBox(height: AppSpace.xl),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.input),
        const SizedBox(height: AppSpace.m),
        const LoadingSkeleton(height: 48, borderRadius: AppRadius.input),
      ],
    );
  }
}
