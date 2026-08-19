/// The sort/filter options on the Search & Filters screen (CU-08).
/// `nearest` is the default per the approved mockup (chip pre-selected).
/// `mostPopular` maps to the backend's `top_selling` sort — used by Home's
/// "الأكثر طلباً" section and its "الكل" link.
enum SearchSortOption {
  nearest,
  topRated,
  mostPopular,
  priceLowToHigh,
  priceHighToLow
}

extension SearchSortOptionFilterKey on SearchSortOption {
  /// The value stored under the `sort` key of the repository's `filters`
  /// map — kept as a small typed->string seam so the mock datasource (and
  /// later a real remote datasource) never has to import this enum.
  String get filterValue => name;
}
