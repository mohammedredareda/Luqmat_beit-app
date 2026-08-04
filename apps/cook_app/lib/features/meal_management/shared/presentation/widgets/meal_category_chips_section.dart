import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/meal_category.dart';

/// "التصنيف" — multi-select category chips (CK-07 allows more than one).
class MealCategoryChipsSection extends StatelessWidget {
  const MealCategoryChipsSection({
    super.key,
    required this.sectionTitle,
    required this.selectedCategoryIds,
    required this.onToggle,
    required this.labelBuilder,
  });

  final String sectionTitle;
  final Set<String> selectedCategoryIds;
  final ValueChanged<String> onToggle;
  final String Function(MealCategory) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: sectionTitle,
      children: [
        Wrap(
          spacing: AppSpace.s,
          runSpacing: AppSpace.s,
          children: [
            for (final category in MealCategory.values)
              FilterChip(
                label: Text(labelBuilder(category)),
                selected: selectedCategoryIds.contains(category.id),
                onSelected: (_) => onToggle(category.id),
              ),
          ],
        ),
      ],
    );
  }
}
