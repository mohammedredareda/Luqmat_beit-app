import 'package:flutter/material.dart';

import '../../domain/entities/home_feed_entity.dart';

class ChefListTile extends StatelessWidget {
  const ChefListTile({super.key, required this.chef, required this.onTap});

  final ChefSummaryEntity chef;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 32, backgroundImage: NetworkImage(chef.avatarUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chef.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: scheme.tertiary),
                      const SizedBox(width: 4),
                      Text('${chef.rating} (${chef.ratingCount}+)'),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on, size: 14, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text('${chef.distanceKm} كم',
                          style: TextStyle(color: scheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_left, color: scheme.primary),
          ],
        ),
      ),
    );
  }
}
