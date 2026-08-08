import 'paginated_result.dart';

/// Shared "load more on scroll" state machinery, mixed into a feature's
/// Bloc/Cubit rather than reimplemented per feature. A filter/query change
/// must call [resetPagination] — never append to a stale list.
mixin PaginationStateMixin<T> {
  List<T> items = [];
  String? cursor;
  bool hasMore = true;
  bool isLoadingMore = false;

  void resetPagination() {
    items = [];
    cursor = null;
    hasMore = true;
    isLoadingMore = false;
  }

  /// Merges a newly-fetched page into [items] and updates [cursor]/[hasMore].
  void appendPage(PaginatedResult<T> page) {
    items = [...items, ...page.items];
    cursor = page.nextCursor;
    hasMore = page.hasMore;
    isLoadingMore = false;
  }
}
