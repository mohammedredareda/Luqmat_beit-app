/// The result categories `GET /user/customer/search` can return, selected
/// via its `types` query param (comma-separated, e.g. `meals,offers`).
enum SearchResultType { meals, offers, cooks, returnedMeals }

extension SearchResultTypeParam on SearchResultType {
  /// The value this type contributes to the `types` query param.
  String get paramValue => switch (this) {
        SearchResultType.meals => 'meals',
        SearchResultType.offers => 'offers',
        SearchResultType.cooks => 'cooks',
        SearchResultType.returnedMeals => 'returned_meals',
      };
}

/// Parses a comma-separated `types` route query param (e.g. `offers` or
/// `offers,returned_meals`) back into a [Set] — used when Home's "الكل"
/// links pre-filter the Search screen. Unknown/empty values are dropped
/// rather than throwing, since this only ever comes from an in-app link.
Set<SearchResultType>? parseSearchResultTypes(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final byParamValue = {
    for (final t in SearchResultType.values) t.paramValue: t
  };
  final parsed = raw
      .split(',')
      .map((v) => byParamValue[v.trim()])
      .whereType<SearchResultType>();
  final result = parsed.toSet();
  return result.isEmpty ? null : result;
}
