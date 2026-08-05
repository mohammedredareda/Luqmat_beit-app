/// One page of a cursor-paginated list — the return shape for every
/// repository method backing an unbounded list (orders, meals, offers,
/// search results, ...). Cursor-based rather than offset/limit: these
/// lists mutate mid-scroll, and "give me everything after item X" doesn't
/// have offset/limit's skip-or-repeat failure mode under concurrent writes.
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.hasMore,
    this.nextCursor,
  });

  final List<T> items;
  final bool hasMore;
  final String? nextCursor;

  /// Transform the page's items (e.g. model → entity) without touching
  /// the paging metadata.
  PaginatedResult<R> map<R>(R Function(T item) transform) {
    return PaginatedResult<R>(
      items: items.map(transform).toList(),
      hasMore: hasMore,
      nextCursor: nextCursor,
    );
  }
}
