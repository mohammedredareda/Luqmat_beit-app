import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/domain/repositories/categories_repository.dart';
import '../../domain/entities/search_result_item.dart';
import '../../domain/entities/search_result_type.dart';
import '../../domain/entities/search_sort_option.dart';
import '../../domain/usecases/search_catalog.dart';
import 'search_state.dart';

const _allSearchResultTypes = {
  SearchResultType.meals,
  SearchResultType.offers,
  SearchResultType.cooks,
  SearchResultType.returnedMeals,
};

/// CU-08. Cursor pagination is handled via [PaginationStateMixin] rather
/// than in the Freezed state — `items`/`cursor`/`hasMore`/`isLoadingMore`
/// live here and the UI reads them straight off the cubit, while
/// [SearchState] only signals the query/filter selection and
/// loading/error shape. Any change to query, sort, category, or types
/// resets pagination and re-fetches page one — never appends to a stale
/// list.
class SearchCubit extends Cubit<SearchState>
    with PaginationStateMixin<SearchResultItem> {
  SearchCubit(this._searchCatalog, this._categoriesRepository)
      : super(const SearchState.initial()) {
    _loadCategories();
  }

  final SearchCatalog _searchCatalog;
  final CategoriesRepository _categoriesRepository;

  String _query = '';
  SearchSortOption _sortOption = SearchSortOption.nearest;
  String? _categoryId;
  Set<SearchResultType> _types = _allSearchResultTypes;
  int _revision = 0;
  List<FoodCategoryEntity> _categories = const [];

  String get query => _query;
  SearchSortOption get sortOption => _sortOption;
  String? get categoryId => _categoryId;
  Set<SearchResultType> get types => _types;
  List<FoodCategoryEntity> get categories => _categories;

  Future<void> _loadCategories() async {
    final result = await _categoriesRepository.getCategories();
    if (isClosed) return;
    result.fold((categories) {
      _categories = categories;
      if (state is SearchLoaded) _emitLoaded();
    }, (_) {});
  }

  /// Seeds the filters before the first [search] call fires — used when
  /// this screen is reached with a pre-selected filter (e.g. Home's
  /// category chips or "الكل" links), never after the first fetch.
  void initFilters({
    String? categoryId,
    SearchSortOption? sortOption,
    Set<SearchResultType>? types,
  }) {
    if (categoryId != null) _categoryId = categoryId;
    if (sortOption != null) _sortOption = sortOption;
    if (types != null && types.isNotEmpty) _types = types;
  }

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

  /// Toggles one result type on/off — refuses to leave the set empty
  /// (falls back to just [SearchResultType.meals]) since an empty `types`
  /// param would be an invalid request.
  Future<void> toggleType(SearchResultType type) async {
    final next = Set<SearchResultType>.of(_types);
    if (next.contains(type)) {
      if (next.length == 1) return;
      next.remove(type);
    } else {
      next.add(type);
    }
    if (next.length == _types.length && next.containsAll(_types)) return;
    _types = next;
    await _resetAndFetch();
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is! SearchLoaded) return;
    isLoadingMore = true;
    _emitLoaded();

    final result = await _searchCatalog(
      query: _query,
      filters: _filters,
      cursor: cursor,
      pageSize: PaginationConstants.defaultPageSize,
    );
    if (isClosed) return;
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

    final result = await _searchCatalog(
      query: _query,
      filters: _filters,
      cursor: null,
      pageSize: PaginationConstants.defaultPageSize,
    );
    if (isClosed) return;
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
        'types': _types.map((t) => t.paramValue).join(','),
      };
}
