import 'paginated_result.dart';

/// Transient paging state mixed into a feature's Cubit/Bloc — tracks what's
/// been fetched so far so the next `loadMore()` call knows which cursor to
/// request. The Cubit still emits its own Freezed state derived from these
/// fields; this mixin only owns the bookkeeping, not what the UI renders.
mixin PaginationStateMixin<T> {
  List<T> items = [];
  String? cursor;
  bool hasMore = true;
  bool isLoadingMore = false;

  /// Clears all paging state — call before re-fetching page one, e.g. on
  /// initial load or when a filter/query change invalidates the list.
  void resetPagination() {
    items = [];
    cursor = null;
    hasMore = true;
    isLoadingMore = false;
  }

  /// Appends a freshly-fetched page and advances the cursor.
  void appendPage(PaginatedResult<T> page) {
    items = [...items, ...page.items];
    cursor = page.nextCursor;
    hasMore = page.hasMore;
    isLoadingMore = false;
  }
}
