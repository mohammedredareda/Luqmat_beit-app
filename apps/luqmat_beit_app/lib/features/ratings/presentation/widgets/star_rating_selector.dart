import 'package:flutter/material.dart';

/// The 5-star selector from the `meal_rating_s9_replica` mockup: outline
/// stars fill with the honey/tertiary token up to the tapped value.
class StarRatingSelector extends StatelessWidget {
  const StarRatingSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.starCount = 5,
    this.size = 40,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int starCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= value;
        return IconButton(
          onPressed: () => onChanged(starValue),
          icon: Icon(
            isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: isFilled ? scheme.tertiary : scheme.surfaceContainerHighest,
          ),
          splashRadius: size,
          tooltip: '$starValue من $starCount نجوم',
        );
      }),
    );
  }
}
