import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../../search/domain/entities/search_result_type.dart';
import '../../../search/domain/entities/search_sort_option.dart';
import '../../domain/entities/home_feed_entity.dart';
import '../../domain/usecases/get_home_feed.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/category_chip.dart';
import '../widgets/chef_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(GetHomeFeed(getIt()))..loadFeed(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Matches the cook module's app bar, which is always in English
        // (see orders_list_page.dart / view_menu_page.dart) — no l10n key
        // exists for either, so this stays a raw literal to match.
        title: const Text('Luqmat Beit'),
        actions: [
          IconButton(
            onPressed: () => context.push('/cart'),
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'السلة',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return switch (state) {
              HomeInitial() || HomeLoading() => const _HomeLoadingSkeleton(),
              HomeFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل الصفحة الرئيسية',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<HomeCubit>().loadFeed(),
                ),
              HomeLoaded(:final feed) => _HomeContent(feed: feed),
            };
          },
        ),
      ),
      bottomNavigationBar:
          const CustomerBottomNav(currentTab: CustomerNavTab.home),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.feed});

  final HomeFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            child: GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                height: 56,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: scheme.outline),
                ),
                child: Row(
                  children: [
                    Icon(Icons.tune, color: scheme.onSurfaceVariant),
                    const SizedBox(width: AppSpace.s),
                    Expanded(
                      child: Text(
                        'بحث عن أكلة أو شيف...',
                        style: textTheme.bodyLarge
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                    Icon(Icons.search, color: scheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
          ),
        ),
        _sectionHeader(
          context,
          'الأصناف',
          onSeeAll: () => context
              .push('/search?types=${SearchResultType.meals.paramValue}'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.categories.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final category = feed.categories[index];
                return CategoryChip(
                  category: category,
                  isSelected: index == 0,
                  onTap: () => context.push(
                    '/search?categoryId=${Uri.encodeQueryComponent(category.id)}&types=${SearchResultType.meals.paramValue}',
                  ),
                );
              },
            ),
          ),
        ),
        _sectionHeader(
          context,
          'الأكثر طلباً',
          onSeeAll: () => context.push(
            '/search?sort=${SearchSortOption.mostPopular.name}&types=${SearchResultType.meals.paramValue}',
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.bestSellers.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final meal = feed.bestSellers[index];
                return SizedBox(
                  width: 240,
                  child: MealCard(
                    meal: meal,
                    isActive: true,
                    currencySuffix: l10n.currencySuffix,
                    onTap: () => context.push('/meal/${meal.id}'),
                  ),
                );
              },
            ),
          ),
        ),
        _sectionHeader(
          context,
          'طباخين متميزين',
          onSeeAll: () => context
              .push('/search?types=${SearchResultType.cooks.paramValue}'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 108,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.chefs.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final chef = feed.chefs[index];
                return SizedBox(
                  width: 280,
                  child: ChefListTile(
                    chef: chef,
                    onTap: () => context.push('/chef/${chef.id}'),
                  ),
                );
              },
            ),
          ),
        ),
        _sectionHeader(
          context,
          'العروض',
          onSeeAll: () => context
              .push('/search?types=${SearchResultType.offers.paramValue}'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 232,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.discountedMeals.length + feed.offerBundles.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                if (index < feed.discountedMeals.length) {
                  final meal = feed.discountedMeals[index];
                  final discount = feed.discountsByMealId[meal.id];
                  return _DiscountCard(
                    meal: meal,
                    discount: discount,
                    currencySuffix: l10n.currencySuffix,
                    onTap: () => context.push('/meal/${meal.id}'),
                  );
                }
                final bundle =
                    feed.offerBundles[index - feed.discountedMeals.length];
                return _BundleOfferCard(
                  bundle: bundle,
                  currencySuffix: l10n.currencySuffix,
                  onTap: () =>
                      context.push('/offer/${bundle.id}', extra: bundle),
                );
              },
            ),
          ),
        ),
        _sectionHeader(
          context,
          'من نصيبك',
          onSeeAll: () => context.push(
              '/search?types=${SearchResultType.returnedMeals.paramValue}'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 232,
            child: feed.returnedMeals.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد وجبات متاحة حالياً',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpace.l),
                    itemCount: feed.returnedMeals.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpace.m),
                    itemBuilder: (context, index) {
                      final item = feed.returnedMeals[index];
                      return _ReturnedMealCard(
                        item: item,
                        currencySuffix: l10n.currencySuffix,
                        onTap: () =>
                            context.push('/meal/${item.mealId}', extra: item),
                      );
                    },
                  ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: AppSpace.l)),
      ],
    );
  }

  SliverToBoxAdapter _sectionHeader(
    BuildContext context,
    String title, {
    required VoidCallback onSeeAll,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpace.l,
          end: AppSpace.l,
          top: AppSpace.xl,
          bottom: AppSpace.m,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: onSeeAll,
              child: Text('الكل', style: TextStyle(color: scheme.primary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountCard extends StatelessWidget {
  const _DiscountCard({
    required this.meal,
    required this.discount,
    required this.currencySuffix,
    required this.onTap,
  });

  final MealEntity meal;
  final DiscountEntity? discount;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final originalPrice = meal.startingPrice;
    final discountedPrice = discount?.apply(originalPrice) ?? originalPrice;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(meal.imageUrl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(AppSpace.s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meal.name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        '${discountedPrice.toStringAsFixed(0)} $currencySuffix',
                        style: TextStyle(
                            color: scheme.primary, fontWeight: FontWeight.bold),
                      ),
                      if (discount != null)
                        Text(
                          '${originalPrice.toStringAsFixed(0)} $currencySuffix',
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (discount != null)
              PositionedDirectional(
                top: AppSpace.s,
                end: AppSpace.s,
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.s,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${discount!.discountPercentage.toStringAsFixed(0)}%-',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BundleOfferCard extends StatelessWidget {
  const _BundleOfferCard({
    required this.bundle,
    required this.currencySuffix,
    required this.onTap,
  });

  final OfferBundleEntity bundle;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final coverImageUrl =
        bundle.meals.isNotEmpty ? bundle.meals.first.imageUrl : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: coverImageUrl.isEmpty
                  ? Container(color: scheme.surfaceContainerHighest)
                  : Image.network(coverImageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(AppSpace.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bundle.name,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    '${bundle.meals.length} وجبات',
                    style:
                        TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
                  ),
                  Text(
                    '${bundle.totalPrice.toStringAsFixed(0)} $currencySuffix',
                    style: TextStyle(
                        color: scheme.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReturnedMealCard extends StatelessWidget {
  const _ReturnedMealCard({
    required this.item,
    required this.currencySuffix,
    required this.onTap,
  });

  final ReturnedMealEntity item;
  final String currencySuffix;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final discountPercentage = item.originalPrice > 0
        ? (1 - item.salvagePrice / item.originalPrice) * 100
        : 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(item.imageUrl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(AppSpace.s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.mealName,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        '${item.salvagePrice.toStringAsFixed(0)} $currencySuffix',
                        style: TextStyle(
                            color: scheme.primary, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item.originalPrice.toStringAsFixed(0)} $currencySuffix',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              top: AppSpace.s,
              end: AppSpace.s,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.s,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${discountPercentage.toStringAsFixed(0)}%-',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeLoadingSkeleton extends StatelessWidget {
  const _HomeLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 56, borderRadius: 16),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 52, width: 200),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 200),
      ],
    );
  }
}
