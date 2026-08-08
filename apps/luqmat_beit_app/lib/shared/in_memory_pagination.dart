import 'package:core/core.dart';

/// Slices an already-filtered, already-sorted in-memory list into one
/// cursor page — the fake datasources' stand-in for a real backend's
/// cursor pagination, shared by orders/meals/offers so the slicing logic
/// isn't reimplemented per feature.
PaginatedResult<T> paginateInMemory<T>({
  required List<T> all,
  required String Function(T item) idOf,
  String? cursor,
  int pageSize = PaginationConstants.defaultPageSize,
}) {
  final startIndex = cursor == null ? 0 : all.indexWhere((e) => idOf(e) == cursor) + 1;
  final page = all.skip(startIndex).take(pageSize).toList(growable: false);
  final hasMore = startIndex + page.length < all.length;
  return PaginatedResult(
    items: page,
    hasMore: hasMore,
    nextCursor: page.isEmpty ? null : idOf(page.last),
  );
}
