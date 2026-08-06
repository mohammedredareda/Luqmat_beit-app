/// Cursor-based, not offset/limit — lists mutate mid-scroll (a cook can go
/// inactive, a new meal can appear), and offset/limit silently duplicates
/// or skips items when that happens.
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.hasMore,
    this.nextCursor,
  });

  final List<T> items;
  final bool hasMore;
  final String? nextCursor;
}
