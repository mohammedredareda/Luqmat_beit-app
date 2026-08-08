import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/search_meals.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_filter_chips_row.dart';
import '../widgets/search_filter_sheet.dart';
import '../widgets/search_query_bar.dart';

/// CU-08 — Search & Filters. Matches
/// `search_filters_u03_final_arabic_replica/code.html`: this is a
/// stack-pushed screen (no bottom nav bar), reached from Home's search bar
/// via `context.push('/search')`.
class SearchFiltersPage extends StatelessWidget {
  const SearchFiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(SearchMeals(getIt()))..search(''),
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
              padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
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
                    SearchInitial() || SearchLoading() => const _SearchLoadingSkeleton(),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
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
          child: SearchFilterChipsRow(
            sortOption: cubit.sortOption,
            categoryId: cubit.categoryId,
            onSortOptionChanged: (option) => context.read<SearchCubit>().setSortOption(option),
            onCategoryChanged: (id) => context.read<SearchCubit>().setCategory(id),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpace.l,
            end: AppSpace.l,
            top: AppSpace.xl,
            bottom: AppSpace.m,
          ),
          child: Text('النتائج (${cubit.items.length})', style: textTheme.titleLarge),
        ),
        Expanded(
          child: cubit.items.isEmpty
              ? EmptyState(
                  icon: Icons.search_off,
                  title: 'لا توجد نتائج',
                  message: 'جرّب كلمات بحث أو تصفية مختلفة.',
                )
              : PaginatedListView<MealEntity>(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l)
                      .add(const EdgeInsetsDirectional.only(bottom: AppSpace.xl)),
                  items: cubit.items,
                  hasMore: cubit.hasMore,
                  isLoadingMore: cubit.isLoadingMore,
                  onLoadMore: () => context.read<SearchCubit>().loadMore(),
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpace.l),
                  itemBuilder: (context, meal, index) {
                    return MealCard(
                      meal: meal,
                      isActive: !meal.isStopped && meal.deletedAt == null,
                      onTap: () => context.push('/meal/${meal.id}'),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<SearchCubit>();
    final result = await SearchFilterSheet.show(
      context,
      sortOption: cubit.sortOption,
      categoryId: cubit.categoryId,
    );
    if (result == null) return;
    if (result.sortOption != cubit.sortOption) cubit.setSortOption(result.sortOption);
    if (result.categoryId != cubit.categoryId) cubit.setCategory(result.categoryId);
  }
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
