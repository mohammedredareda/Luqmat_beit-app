import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../shared/domain/entities/short_management_entity.dart';

/// One card in "My Shorts" (mockup `_4`) — 9:16, view-count badge, optional
/// linked-meal pill, delete icon.
class ShortGalleryCard extends StatelessWidget {
  const ShortGalleryCard({super.key, required this.short, required this.onDelete});

  final ShortManagementEntity short;
  final VoidCallback onDelete;

  String _formatViewCount(int count) {
    if (count < 1000) return '$count';
    return '${(count / 1000).toStringAsFixed(count % 1000 >= 100 ? 1 : 0)}k';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasThumbnail = short.thumbnailUrl != null && short.thumbnailUrl!.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasThumbnail)
            Image.network(
              short.thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholder(scheme),
            )
          else
            _placeholder(scheme),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, scheme.scrim.withValues(alpha: 0.55)],
                stops: const [0.6, 1.0],
              ),
            ),
          ),
          const Center(
            child: Icon(Icons.play_circle, color: Colors.white, size: 40),
          ),
          PositionedDirectional(
            top: AppSpace.s,
            start: AppSpace.s,
            child: _Badge(
              icon: Icons.visibility_outlined,
              label: _formatViewCount(short.viewCount),
            ),
          ),
          PositionedDirectional(
            top: AppSpace.s,
            end: AppSpace.s,
            child: _DeleteButton(onPressed: onDelete),
          ),
          if (short.hasLinkedMeal)
            PositionedDirectional(
              bottom: AppSpace.s,
              start: AppSpace.s,
              end: AppSpace.s,
              child: _Badge(
                icon: Icons.restaurant_outlined,
                label: short.mealName ?? '',
                textStyle: textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }

  Widget _placeholder(ColorScheme scheme) => Container(
        color: scheme.surfaceContainerHighest,
        child: Icon(Icons.movie_creation_outlined, size: 40, color: scheme.onSurfaceVariant),
      );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label, this.textStyle});

  final IconData icon;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s, vertical: AppSpace.xs),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: AppSpace.xs),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (textStyle ?? Theme.of(context).textTheme.bodySmall)
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(AppSpace.xs),
          child: Icon(Icons.delete_outline, size: 18, color: Colors.white),
        ),
      ),
    );
  }
}
