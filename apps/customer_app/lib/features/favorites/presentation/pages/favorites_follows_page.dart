import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../../home/domain/entities/home_feed_entity.dart';
import '../../domain/usecases/get_favorite_meals.dart';
import '../../domain/usecases/get_followed_chefs.dart';
import '../../domain/usecases/unfavorite_meal.dart';
import '../../domain/usecases/unfollow_chef.dart';
import '../cubit/favorites_follows_cubit.dart';
import '../cubit/favorites_follows_state.dart';
import '../widgets/favorite_meal_card.dart';
import '../widgets/followed_chef_tile.dart';

/// CU-12 (favorited meals), CU-13 (followed chefs), CU-14 (unfavorite /
/// unfollow toggle). Router path `/favorites`.
class FavoritesFollowsPage extends StatelessWidget {
  const FavoritesFollowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesFollowsCubit(
        GetFavoriteMeals(getIt()),
        GetFollowedChefs(getIt()),
        UnfavoriteMeal(getIt()),
        UnfollowChef(getIt()),
      )..load(),
      child: const _FavoritesFollowsView(),
    );
  }
}

class _FavoritesFollowsView extends StatelessWidget {
  const _FavoritesFollowsView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(scheme: scheme),
            BlocBuilder<FavoritesFollowsCubit, FavoritesFollowsState>(
              builder: (context, state) {
                final activeTab = state is FavoritesFollowsLoaded
                    ? state.activeTab
                    : FavoritesTab.meals;
                return _TabsBar(activeTab: activeTab);
              },
            ),
            Expanded(
              child: BlocBuilder<FavoritesFollowsCubit, FavoritesFollowsState>(
                builder: (context, state) {
                  return switch (state) {
                    FavoritesFollowsInitial() || FavoritesFollowsLoading() =>
                      const _FavoritesLoadingSkeleton(),
                    FavoritesFollowsFailure(:final exception) => EmptyState(
                        icon: Icons.wifi_off,
                        title: 'تعذر تحميل المفضلة',
                        message: exception.message,
                        actionLabel: 'إعادة المحاولة',
                        onAction: () => context.read<FavoritesFollowsCubit>().load(),
                      ),
                    FavoritesFollowsLoaded(:final meals, :final chefs, :final activeTab) =>
                      activeTab == FavoritesTab.meals
                          ? _FavoriteMealsGrid(meals: meals)
                          : _FollowedChefsList(chefs: chefs),
                  };
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomerBottomNav(currentTab: CustomerNavTab.favorites),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l, vertical: AppSpace.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: scheme.primary),
            onPressed: () => context.push('/notifications'),
          ),
          Text(
            'المفضلة ♥',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: scheme.primary, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back, color: scheme.primary),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}

class _TabsBar extends StatelessWidget {
  const _TabsBar({required this.activeTab});

  final FavoritesTab activeTab;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: scheme.outline.withValues(alpha: 0.3)),
        ),
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'وجبات مفضلة',
              isSelected: activeTab == FavoritesTab.meals,
              onTap: () => context.read<FavoritesFollowsCubit>().selectTab(FavoritesTab.meals),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'طباخات أتابعها',
              isSelected: activeTab == FavoritesTab.chefs,
              onTap: () => context.read<FavoritesFollowsCubit>().selectTab(FavoritesTab.chefs),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              color: isSelected ? scheme.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class _FavoriteMealsGrid extends StatelessWidget {
  const _FavoriteMealsGrid({required this.meals});

  final List<MealEntity> meals;

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const EmptyState(
        icon: Icons.favorite_border,
        title: 'لا توجد وجبات مفضلة بعد',
        message: 'أضف الوجبات التي تعجبك إلى المفضلة لتجدها هنا بسهولة.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpace.m,
        mainAxisSpacing: AppSpace.m,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];
        return FavoriteMealCard(
          meal: meal,
          onTap: () => context.push('/meal/${meal.id}'),
          onUnfavorite: () => context.read<FavoritesFollowsCubit>().unfavoriteMeal(meal.id),
        );
      },
    );
  }
}

class _FollowedChefsList extends StatelessWidget {
  const _FollowedChefsList({required this.chefs});

  final List<ChefSummaryEntity> chefs;

  @override
  Widget build(BuildContext context) {
    if (chefs.isEmpty) {
      return const EmptyState(
        icon: Icons.person_search_outlined,
        title: 'لا تتابع أي طباخة بعد',
        message: 'تابع الطباخات المفضلة لديك لمتابعة أطباقهم الجديدة.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: chefs.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpace.m),
      itemBuilder: (context, index) {
        final chef = chefs[index];
        return FollowedChefTile(
          chef: chef,
          onTap: () => context.push('/chef/${chef.id}'),
          onUnfollow: () => context.read<FavoritesFollowsCubit>().unfollowChef(chef.id),
        );
      },
    );
  }
}

class _FavoritesLoadingSkeleton extends StatelessWidget {
  const _FavoritesLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpace.m,
        mainAxisSpacing: AppSpace.m,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (_, _) => const LoadingSkeleton(borderRadius: 16),
    );
  }
}
