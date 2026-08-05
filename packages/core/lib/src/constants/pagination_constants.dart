/// Shared paging knobs, reused by every cursor-paginated list in either app.
abstract final class PaginationConstants {
  static const int defaultPageSize = 20;

  /// Fraction of the scroll extent at which [PaginatedListView] fires
  /// `onLoadMore` — 0.8 means "80% scrolled", not "80% of items loaded".
  static const double prefetchThreshold = 0.8;
}
