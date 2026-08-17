import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// "التصنيف" — multi-select category chips (CK-07 allows more than one).
/// [categories] is the flattened (parents + subcategories) real catalog
/// fetched from `GET /user/customer/categories` — labels render the
/// backend's own `name` directly (already Arabic-first, per the app's
/// source locale) rather than a local l10n lookup, since arbitrary
/// backend-driven categories have no matching translation keys.
class MealCategoryChipsSection extends StatelessWidget {
  const MealCategoryChipsSection({
    super.key,
    required this.sectionTitle,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onToggle,
  });

  final String sectionTitle;
  final List<FoodCategoryEntity> categories;
  final Set<String> selectedCategoryIds;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: sectionTitle,
      children: [
        Wrap(
          spacing: AppSpace.s,
          runSpacing: AppSpace.s,
          children: [
            for (final category in categories)
              FilterChip(
                label: Text(category.name),
                selected: selectedCategoryIds.contains(category.id),
                onSelected: (_) => onToggle(category.id),
              ),
          ],
        ),
      ],
    );
  }
}
