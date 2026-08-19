import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../../categories/domain/repositories/categories_repository.dart';
import '../../domain/entities/search_result_item.dart';
import '../../domain/entities/search_result_type.dart';
import '../../domain/entities/search_sort_option.dart';
import '../../domain/usecases/search_catalog.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_cook_result_tile.dart';
import '../widgets/search_filter_sheet.dart';
import '../widgets/search_offer_result_tile.dart';
import '../widgets/search_query_bar.dart';
import '../widgets/search_returned_meal_result_tile.dart';
import '../widgets/search_type_filter_row.dart';

/// CU-08 — Search & Filters. Matches
/// `search_filters_u03_final_arabic_replica/code.html`: this is a
/// stack-pushed screen (no bottom nav bar), reached from Home's search bar,
/// category chips, or a section's "الكل" link via `context.push('/search')`
/// (optionally with `categoryId`/`sort`/`types` query params).
class SearchFiltersPage extends StatelessWidget {
  const SearchFiltersPage({
    super.key,
    this.initialCategoryId,
    this.initialSortOption,
    this.initialTypes,
  });

  final String? initialCategoryId;
  final SearchSortOption? initialSortOption;
  final Set<SearchResultType>? initialTypes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SearchCubit(SearchCatalog(getIt()), getIt<CategoriesRepository>())
            ..initFilters(
              categoryId: initialCategoryId,
              sortOption: initialSortOption,
              types: initialTypes,
            )
            ..search(''),
      child: const _SearchFiltersView(),
    );
  }
}

class _SearchFiltersView extends StatelessWidget {
  const _SearchFiltersView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48, height: 48),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: scheme.primary,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return switch (state) {
                    SearchInitial() ||
                    SearchLoading() =>
                      const _SearchLoadingSkeleton(),
                    SearchFailure(:final exception) => EmptyState(
                        icon: Icons.wifi_off,
                        title: 'تعذر تحميل نتائج البحث',
                        message: exception.message,
                        actionLabel: 'إعادة المحاولة',
                        onAction: () => context.read<SearchCubit>().search(
                              context.read<SearchCubit>().query,
                            ),
                      ),
                    SearchLoaded(:final query) => _SearchContent(query: query),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();
    final textTheme = Theme.of(context).textTheme;
    final currencySuffix = AppLocalizations.of(context)!.currencySuffix;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
          child: SearchQueryBar(
            initialQuery: query,
            onSubmitted: (value) => context.read<SearchCubit>().search(value),
            onTuneTap: () => _openFilterSheet(context),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpace.l,
            end: AppSpace.l,
            top: AppSpace.l,
          ),
          child: SearchTypeFilterRow(
            types: cubit.types,
            onTypeToggled: (type) =>
                context.read<SearchCubit>().toggleType(type),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpace.l,
            end: AppSpace.l,
            top: AppSpace.xl,
            bottom: AppSpace.m,
          ),
          child: Text('النتائج (${cubit.items.length})',
              style: textTheme.titleLarge),
        ),
        Expanded(
          child: cubit.items.isEmpty
              ? EmptyState(
                  icon: Icons.search_off,
                  title: 'لا توجد نتائج',
                  message: 'جرّب كلمات بحث أو تصفية مختلفة.',
                )
              : PaginatedListView<_DisplayRow>(
                  padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpace.l)
                      .add(const EdgeInsetsDirectional.only(
                          bottom: AppSpace.xl)),
                  // Grouped by type into sections once more than one type is
                  // selected — a single type stays a plain list (a lone
                  // section header would be redundant).
                  items: _buildDisplayRows(cubit.items, cubit.types.length > 1),
                  hasMore: cubit.hasMore,
                  isLoadingMore: cubit.isLoadingMore,
                  onLoadMore: () => context.read<SearchCubit>().loadMore(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpace.l),
                  itemBuilder: (context, row, index) {
                    return switch (row) {
                      _SectionHeaderRow(:final title) =>
                        Text(title, style: textTheme.titleMedium),
                      _ItemRow(:final result) => switch (result) {
                          SearchResultMeal(:final meal) => MealCard(
                              meal: meal,
                              isActive:
                                  !meal.isStopped && meal.deletedAt == null,
                              currencySuffix: currencySuffix,
                              onTap: () => context.push('/meal/${meal.id}'),
                            ),
                          SearchResultOffer(:final offer) =>
                            SearchOfferResultTile(
                              offer: offer,
                              currencySuffix: currencySuffix,
                              onTap: () => context.push('/offer/${offer.id}',
                                  extra: offer),
                            ),
                          SearchResultCook(:final cook) => SearchCookResultTile(
                              cook: cook,
                              onTap: () => context.push('/chef/${cook.id}'),
                            ),
                          SearchResultReturnedMeal(:final returnedMeal) =>
                            SearchReturnedMealResultTile(
                              item: returnedMeal,
                              currencySuffix: currencySuffix,
                              onTap: () => context.push(
                                  '/meal/${returnedMeal.mealId}',
                                  extra: returnedMeal),
                            ),
                        },
                    };
                  },
                ),
        ),
      ],
    );
  }

  List<_DisplayRow> _buildDisplayRows(
      List<SearchResultItem> items, bool grouped) {
    if (!grouped) return items.map(_ItemRow.new).toList();

    final meals = items.whereType<SearchResultMeal>();
    final offers = items.whereType<SearchResultOffer>();
    final cooks = items.whereType<SearchResultCook>();
    final returnedMeals = items.whereType<SearchResultReturnedMeal>();

    return [
      ...meals.isEmpty
          ? const []
          : [_SectionHeaderRow('الوجبات'), ...meals.map(_ItemRow.new)],
      ...offers.isEmpty
          ? const []
          : [_SectionHeaderRow('العروض'), ...offers.map(_ItemRow.new)],
      ...cooks.isEmpty
          ? const []
          : [_SectionHeaderRow('الطباخين'), ...cooks.map(_ItemRow.new)],
      ...returnedMeals.isEmpty
          ? const []
          : [_SectionHeaderRow('من نصيبك'), ...returnedMeals.map(_ItemRow.new)],
    ];
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<SearchCubit>();
    final result = await SearchFilterSheet.show(
      context,
      sortOption: cubit.sortOption,
      categoryId: cubit.categoryId,
      categories: cubit.categories,
    );
    if (result == null) return;
    if (result.sortOption != cubit.sortOption)
      cubit.setSortOption(result.sortOption);
    if (result.categoryId != cubit.categoryId)
      cubit.setCategory(result.categoryId);
  }
}

/// One row of the (optionally grouped) results list — either a section
/// title or a result. Page-local only, so a plain sealed class is enough;
/// no Freezed/domain modeling needed for a display-only grouping.
sealed class _DisplayRow {}

class _SectionHeaderRow extends _DisplayRow {
  _SectionHeaderRow(this.title);
  final String title;
}

class _ItemRow extends _DisplayRow {
  _ItemRow(this.result);
  final SearchResultItem result;
}

class _SearchLoadingSkeleton extends StatelessWidget {
  const _SearchLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 48, borderRadius: 999),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 40, width: 240, borderRadius: 999),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 220, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 220, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 220, borderRadius: 16),
      ],
    );
  }
}
