import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import '../../../../categories/domain/repositories/categories_repository.dart';
import 'meal_category_chips_section.dart';

/// Fetches the real category catalog (`GET /user/customer/categories`) once
/// and renders [MealCategoryChipsSection], flattening top-level categories
/// with their subcategories into one selectable list — CK-07's chip UI has
/// no hierarchy affordance, so parents and children render side by side.
class MealCategoryPicker extends StatefulWidget {
  const MealCategoryPicker({
    super.key,
    required this.sectionTitle,
    required this.selectedCategoryIds,
    required this.onToggle,
    required this.errorLabel,
    required this.retryLabel,
  });

  final String sectionTitle;
  final Set<String> selectedCategoryIds;
  final ValueChanged<String> onToggle;
  final String errorLabel;
  final String retryLabel;

  @override
  State<MealCategoryPicker> createState() => _MealCategoryPickerState();
}

class _MealCategoryPickerState extends State<MealCategoryPicker> {
  late Future<Result<List<FoodCategoryEntity>>> _future;

  @override
  void initState() {
    super.initState();
    _future = getIt<CategoriesRepository>().getCategories();
  }

  void _retry() {
    setState(() => _future = getIt<CategoriesRepository>().getCategories());
  }

  List<FoodCategoryEntity> _flatten(List<FoodCategoryEntity> categories) => [
        for (final category in categories) ...[category, ...category.subcategories],
      ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<List<FoodCategoryEntity>>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return FormSectionCard(
            title: widget.sectionTitle,
            children: [
              Wrap(
                spacing: AppSpace.s,
                runSpacing: AppSpace.s,
                children: List.generate(
                  4,
                  (_) => const LoadingSkeleton(width: 72, height: 32, borderRadius: 16),
                ),
              ),
            ],
          );
        }

        return snapshot.data!.fold(
          (categories) => MealCategoryChipsSection(
            sectionTitle: widget.sectionTitle,
            categories: _flatten(categories),
            selectedCategoryIds: widget.selectedCategoryIds,
            onToggle: widget.onToggle,
          ),
          (exception) => FormSectionCard(
            title: widget.sectionTitle,
            children: [
              Text(widget.errorLabel),
              const SizedBox(height: AppSpace.s),
              OutlinedButton(onPressed: _retry, child: Text(widget.retryLabel)),
            ],
          ),
        );
      },
    );
  }
}
