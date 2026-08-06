import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/search_sort_option.dart';
import '../../domain/usecases/search_meals.dart';
import 'search_state.dart';

/// CU-08. Cursor pagination is handled via [PaginationStateMixin] rather
/// than in the Freezed state — `items`/`cursor`/`hasMore`/`isLoadingMore`
/// live here and the UI reads them straight off the cubit, while
/// [SearchState] only signals the query/filter selection and
/// loading/error shape. Any change to query, sort, or category resets
/// pagination and re-fetches page one — never appends to a stale list.
class SearchCubit extends Cubit<SearchState> with PaginationStateMixin<MealEntity> {
  SearchCubit(this._searchMeals) : super(const SearchState.initial());

  final SearchMeals _searchMeals;

  String _query = '';
  SearchSortOption _sortOption = SearchSortOption.nearest;
  String? _categoryId;
  int _revision = 0;

  String get query => _query;
  SearchSortOption get sortOption => _sortOption;
  String? get categoryId => _categoryId;

  Future<void> search(String query) async {
    _query = query;
    await _resetAndFetch();
  }

  Future<void> setSortOption(SearchSortOption option) async {
    if (_sortOption == option) return;
    _sortOption = option;
    await _resetAndFetch();
  }

  Future<void> setCategory(String? categoryId) async {
    if (_categoryId == categoryId) return;
    _categoryId = categoryId;
    await _resetAndFetch();
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is! SearchLoaded) return;
    isLoadingMore = true;
    _emitLoaded();

    final result = await _searchMeals(
      query: _query,
      filters: _filters,
      cursor: cursor,
      pageSize: PaginationConstants.defaultPageSize,
    );
    result.fold(
      (page) {
        items = [...items, ...page.items];
        cursor = page.nextCursor;
        hasMore = page.hasMore;
        isLoadingMore = false;
        _emitLoaded();
      },
      (exception) {
        isLoadingMore = false;
        emit(SearchState.failure(exception));
      },
    );
  }

  Future<void> _resetAndFetch() async {
    resetPagination();
    emit(const SearchState.loading());

    final result = await _searchMeals(
      query: _query,
      filters: _filters,
      cursor: null,
      pageSize: PaginationConstants.defaultPageSize,
    );
    result.fold(
      (page) {
        items = page.items;
        cursor = page.nextCursor;
        hasMore = page.hasMore;
        _emitLoaded();
      },
      (exception) => emit(SearchState.failure(exception)),
    );
  }

  void _emitLoaded() {
    _revision++;
    emit(SearchState.loaded(
      query: _query,
      sortOption: _sortOption,
      categoryId: _categoryId,
      revision: _revision,
    ));
  }

  Map<String, dynamic> get _filters => {
        'sort': _sortOption.filterValue,
        if (_categoryId != null) 'categoryId': _categoryId,
      };
}
