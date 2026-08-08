import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Driver/rider info card shown above the order summary. There is no
/// `DriverEntity` in `packages/core` yet (only cook/order entities), so — to
/// avoid inventing a new core entity for a single screen — this widget
/// takes plain display fields; a real driver-tracking feature would
/// promote this to a proper entity later.
class DeliveryDriverCard extends StatelessWidget {
  const DeliveryDriverCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.ratingCount,
    required this.statusLabel,
  });

  final String name;
  final String avatarUrl;
  final double rating;
  final int ratingCount;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: AppColors.inkLight.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpace.l),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: textTheme.titleLarge),
                const SizedBox(height: AppSpace.xs),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: scheme.onSurfaceVariant),
                    const SizedBox(width: AppSpace.xs),
                    Text(
                      '$rating ($ratingCount تقييم)',
                      style: textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpace.m,
              vertical: AppSpace.xs,
            ),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              statusLabel,
              style: textTheme.labelLarge
                  ?.copyWith(color: scheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
