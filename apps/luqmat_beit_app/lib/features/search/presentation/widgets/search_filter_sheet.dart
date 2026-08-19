import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/search_sort_option.dart';

/// Bottom sheet opened by the "tune" icon and by the "السعر"/"الصنف" chips.
/// No separate mockup exists for this sheet's contents — only the
/// collapsed chip-row state is in the approved `code.html` — so this is a
/// reasonable interpretation (category picker + sort-by-price options)
/// built from the Sumac tokens rather than a pixel spec.
class SearchFilterSheet extends StatefulWidget {
  const SearchFilterSheet({
    super.key,
    required this.sortOption,
    required this.categoryId,
    required this.categories,
  });

  final SearchSortOption sortOption;
  final String? categoryId;
  final List<FoodCategoryEntity> categories;

  static Future<({SearchSortOption sortOption, String? categoryId})?> show(
    BuildContext context, {
    required SearchSortOption sortOption,
    required String? categoryId,
    required List<FoodCategoryEntity> categories,
  }) {
    return showModalBottomSheet<
        ({SearchSortOption sortOption, String? categoryId})>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(AppRadius.sheet)),
      ),
      builder: (_) => SearchFilterSheet(
        sortOption: sortOption,
        categoryId: categoryId,
        categories: categories,
      ),
    );
  }

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late SearchSortOption _sortOption = widget.sortOption;
  String? _categoryId;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpace.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الترتيب حسب', style: textTheme.titleLarge),
            const SizedBox(height: AppSpace.m),
            Wrap(
              spacing: AppSpace.s,
              runSpacing: AppSpace.s,
              children: [
                _sortTile(SearchSortOption.nearest, 'الأقرب'),
                _sortTile(SearchSortOption.topRated, 'الأعلى تقييماً'),
                _sortTile(SearchSortOption.mostPopular, 'الأكثر طلباً'),
                _sortTile(
                    SearchSortOption.priceLowToHigh, 'السعر: الأقل أولاً'),
                _sortTile(
                    SearchSortOption.priceHighToLow, 'السعر: الأعلى أولاً'),
              ],
            ),
            const SizedBox(height: AppSpace.xl),
            Text('الصنف', style: textTheme.titleLarge),
            const SizedBox(height: AppSpace.m),
            Wrap(
              spacing: AppSpace.s,
              runSpacing: AppSpace.s,
              children: [
                _categoryTile(null, 'الكل'),
                for (final category in widget.categories)
                  _categoryTile(category.id, category.name),
              ],
            ),
            const SizedBox(height: AppSpace.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: AppSpace.m),
                ),
                onPressed: () => Navigator.of(context).pop((
                  sortOption: _sortOption,
                  categoryId: _categoryId,
                )),
                child: const Text('تطبيق'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortTile(SearchSortOption option, String label) {
    final selected = _sortOption == option;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _sortOption = option),
    );
  }

  Widget _categoryTile(String? categoryId, String label) {
    final selected = _categoryId == categoryId;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _categoryId = categoryId),
    );
  }
}
