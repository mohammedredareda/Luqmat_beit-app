import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
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
              HomeLoaded(:final feed, :final selectedCategoryId) =>
                _HomeContent(feed: feed, selectedCategoryId: selectedCategoryId),
            };
          },
        ),
      ),
      bottomNavigationBar: const CustomerBottomNav(currentTab: CustomerNavTab.home),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.feed, this.selectedCategoryId});

  final HomeFeedEntity feed;
  final String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            child: GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                height: 56,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: _PromoBanner(scheme: scheme, textTheme: textTheme),
          ),
        ),
        _sectionHeader(context, 'الأصناف', onSeeAll: () {}),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final category = feed.categories[index];
                final isSelected = selectedCategoryId == null
                    ? index == 0
                    : selectedCategoryId == category.id;
                return CategoryChip(
                  category: category,
                  isSelected: isSelected,
                  onTap: () => context.read<HomeCubit>().selectCategory(category.id),
                );
              },
            ),
          ),
        ),
        _sectionHeader(context, 'الأكثر طلباً', onSeeAll: () {}),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.bestSellers.length,
              separatorBuilder: (context, index) => const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final meal = feed.bestSellers[index];
                return SizedBox(
                  width: 240,
                  child: MealCard(
                    meal: meal,
                    isActive: true,
                    onTap: () => context.push('/meal/${meal.id}'),
                  ),
                );
              },
            ),
          ),
        ),
        _sectionHeader(context, 'طباخين متميزين', onSeeAll: () {}),
        SliverPadding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
          sliver: SliverList.separated(
            itemCount: feed.chefs.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpace.m),
            itemBuilder: (context, index) {
              final chef = feed.chefs[index];
              return ChefListTile(
                chef: chef,
                onTap: () => context.push('/chef/${chef.id}'),
              );
            },
          ),
        ),
        _sectionHeader(context, 'العروض', onSeeAll: () {}),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              itemCount: feed.offers.length,
              separatorBuilder: (context, index) => const SizedBox(width: AppSpace.m),
              itemBuilder: (context, index) {
                final meal = feed.offers[index];
                return _OfferCard(meal: meal, onTap: () => context.push('/meal/${meal.id}'));
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.l,
            vertical: AppSpace.l,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('خصومات ضخمة', style: textTheme.titleLarge),
                    Row(
                      children: [
                        Icon(Icons.savings, size: 16, color: scheme.secondary),
                        const SizedBox(width: 4),
                        Text('خصومات حتى 50%',
                            style: TextStyle(color: scheme.secondary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.m),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: feed.bigDiscounts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpace.m,
                    mainAxisSpacing: AppSpace.m,
                    childAspectRatio: 0.66,
                  ),
                  itemBuilder: (context, index) {
                    final meal = feed.bigDiscounts[index];
                    final discount = feed.discountsByMealId[meal.id];
                    return _DiscountCard(
                      meal: meal,
                      discount: discount,
                      onTap: () => context.push('/meal/${meal.id}'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.scheme, required this.textTheme});

  final ColorScheme scheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sheet),
      child: Container(
        height: 192,
        decoration: const BoxDecoration(color: Color(0xFF2A211A)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.35)),
            ),
            PositionedDirectional(
              start: 32,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpace.m,
                        vertical: AppSpace.xs,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text('عرض محدود', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: AppSpace.s),
                    const Text(
                      'أشهى الطبخات البيتية\nبخصم 30% لأول طلب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpace.s),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: scheme.primary,
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpace.xl,
                          vertical: AppSpace.s,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('اطلب الآن'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.meal, required this.onTap});

  final MealEntity meal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.1)),
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
                      Text(meal.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(
                        '${meal.startingPrice.toStringAsFixed(0)} ₪',
                        style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              top: AppSpace.s,
              start: AppSpace.s,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.s,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '٪25 خصم',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountCard extends StatelessWidget {
  const _DiscountCard({required this.meal, required this.discount, required this.onTap});

  final MealEntity meal;
  final DiscountEntity? discount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final originalPrice = meal.startingPrice;
    final discountedPrice = discount?.apply(originalPrice) ?? originalPrice;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                      Text(meal.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        '${discountedPrice.toStringAsFixed(0)} ₪',
                        style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold),
                      ),
                      if (discount != null)
                        Text(
                          '${originalPrice.toStringAsFixed(0)} ₪',
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
                        color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
        LoadingSkeleton(height: 192, borderRadius: 24),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 52, width: 200),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 200),
      ],
    );
  }
}
