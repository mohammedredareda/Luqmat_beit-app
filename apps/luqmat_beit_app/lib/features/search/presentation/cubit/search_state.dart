import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/search_sort_option.dart';

part 'search_state.freezed.dart';

/// Single fetch-filter-and-display flow (CU-08), no UI-distinct branching
/// outcomes — a Cubit, not a Bloc, per the architecture doc's decision
/// rule. The loaded item list itself lives on [SearchCubit] via
/// `PaginationStateMixin` (mutable, appended to on load-more) rather than
/// in this Freezed union — only the query/filter selection and the
/// loading/error signal need to trigger a rebuild shape change.
@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;

  /// First page of a fresh query/filter combination is in flight — the
  /// existing list has already been cleared by `resetPagination()`.
  const factory SearchState.loading() = SearchLoading;

  /// [revision] has no meaning of its own — it exists purely so each fetch
  /// (including a `loadMore()` that changes none of query/sortOption/
  /// categoryId) produces a `SearchLoaded` that is `!=` the previous one.
  /// Without it, Freezed's value-equality would make `Cubit.emit` silently
  /// drop the update, since the actual list/hasMore/isLoadingMore live on
  /// the cubit (`PaginationStateMixin`), not in this state.
  const factory SearchState.loaded({
    required String query,
    required SearchSortOption sortOption,
    String? categoryId,
    required int revision,
  }) = SearchLoaded;

  const factory SearchState.failure(AppException exception) = SearchFailure;
}
