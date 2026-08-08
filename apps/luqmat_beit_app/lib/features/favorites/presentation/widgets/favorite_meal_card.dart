import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Wraps the shared [MealCard] with a favorite (heart) toggle overlay, as
/// shown on the favorited-meals tab of the mockup — [MealCard] itself has
/// no favorite affordance since Home/Search never show one (R-24: only
/// meal details exposes ordering actions; this toggle is favorites-only).
class FavoriteMealCard extends StatelessWidget {
  const FavoriteMealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onUnfavorite,
  });

  final MealEntity meal;
  final VoidCallback onTap;
  final VoidCallback onUnfavorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        MealCard(meal: meal, isActive: true, onTap: onTap),
        PositionedDirectional(
          top: AppSpace.s,
          end: AppSpace.s,
          child: GestureDetector(
            onTap: onUnfavorite,
            child: Container(
              padding: const EdgeInsetsDirectional.all(AppSpace.xs),
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, color: scheme.primary, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
