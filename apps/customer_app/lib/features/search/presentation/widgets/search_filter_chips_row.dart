import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../shared/mock/sample_catalog.dart';
import '../../domain/entities/search_sort_option.dart';
import 'search_filter_chip.dart';
import 'search_filter_sheet.dart';

/// The horizontal, scrollable chip row from `code.html` ("Filter Chips"):
/// الأقرب / الأعلى تقييماً toggle sort directly; السعر / الصنف open
/// [SearchFilterSheet] since their options don't fit a single chip label.
class SearchFilterChipsRow extends StatelessWidget {
  const SearchFilterChipsRow({
    super.key,
    required this.sortOption,
    required this.categoryId,
    required this.onSortOptionChanged,
    required this.onCategoryChanged,
  });

  final SearchSortOption sortOption;
  final String? categoryId;
  final ValueChanged<SearchSortOption> onSortOptionChanged;
  final ValueChanged<String?> onCategoryChanged;

  Future<void> _openSheet(BuildContext context) async {
    final result = await SearchFilterSheet.show(
      context,
      sortOption: sortOption,
      categoryId: categoryId,
    );
    if (result == null) return;
    if (result.sortOption != sortOption) onSortOptionChanged(result.sortOption);
    if (result.categoryId != categoryId) onCategoryChanged(result.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final isPriceSort = sortOption == SearchSortOption.priceLowToHigh ||
        sortOption == SearchSortOption.priceHighToLow;
    final categoryLabel = categoryId == null
        ? 'الصنف'
        : SampleCatalog.categories
            .firstWhere((c) => c.id == categoryId, orElse: () => SampleCatalog.categories.first)
            .label;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SearchFilterChip(
            label: 'الأقرب',
            selected: sortOption == SearchSortOption.nearest,
            onTap: () => onSortOptionChanged(SearchSortOption.nearest),
          ),
          const SizedBox(width: AppSpace.s),
          SearchFilterChip(
            label: 'الأعلى تقييماً',
            selected: sortOption == SearchSortOption.topRated,
            onTap: () => onSortOptionChanged(SearchSortOption.topRated),
          ),
          const SizedBox(width: AppSpace.s),
          SearchFilterChip(
            label: 'السعر',
            selected: isPriceSort,
            trailingDropdown: true,
            onTap: () => _openSheet(context),
          ),
          const SizedBox(width: AppSpace.s),
          SearchFilterChip(
            label: categoryLabel,
            selected: categoryId != null,
            trailingDropdown: true,
            onTap: () => _openSheet(context),
          ),
        ],
      ),
    );
  }
}
