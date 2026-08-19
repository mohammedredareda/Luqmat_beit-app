import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/search_result_type.dart';
import 'search_filter_chip.dart';

const _typeLabels = {
  SearchResultType.meals: 'الوجبات',
  SearchResultType.offers: 'العروض',
  SearchResultType.cooks: 'الطباخين',
  SearchResultType.returnedMeals: 'من نصيبك',
};

/// Lets the customer pick which result kinds to search — meals, offers,
/// cooks, "من نصيبك" (returned/salvage meals) — any combination, sent as
/// the backend's comma-separated `types` param. Sort/category filters live
/// only behind the search bar's tune icon ([SearchFilterSheet]), not here.
class SearchTypeFilterRow extends StatelessWidget {
  const SearchTypeFilterRow(
      {super.key, required this.types, required this.onTypeToggled});

  final Set<SearchResultType> types;
  final ValueChanged<SearchResultType> onTypeToggled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: SearchResultType.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpace.s),
        itemBuilder: (context, index) {
          final type = SearchResultType.values[index];
          return SearchFilterChip(
            label: _typeLabels[type]!,
            selected: types.contains(type),
            onTap: () => onTypeToggled(type),
          );
        },
      ),
    );
  }
}
