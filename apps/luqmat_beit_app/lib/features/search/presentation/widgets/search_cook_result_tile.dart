import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Row-style cook result in the Search list — a local, search-scoped
/// counterpart to Home's `ChefListTile` (kept separate rather than a
/// cross-feature import, since Home and Search are independent features).
class SearchCookResultTile extends StatelessWidget {
  const SearchCookResultTile(
      {super.key, required this.cook, required this.onTap});

  final ChefSummaryEntity cook;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 32, backgroundImage: NetworkImage(cook.avatarUrl)),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cook.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpace.xs),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: scheme.tertiary),
                      const SizedBox(width: AppSpace.xs),
                      Text(cook.rating.toStringAsFixed(1)),
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
