import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/entities/chef_profile_entity.dart';
import '../../domain/repositories/chef_repository.dart';
import '../../domain/usecases/get_chef_profile.dart';
import '../../domain/usecases/toggle_follow_chef.dart';
import '../cubit/chef_profile_cubit.dart';
import '../cubit/chef_profile_state.dart';
import '../widgets/chef_meal_list_tile.dart';
import '../widgets/chef_profile_header.dart';
import '../widgets/menu_filter_chip.dart';

class ChefProfilePage extends StatelessWidget {
  const ChefProfilePage({super.key, required this.chefId});

  final String chefId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChefProfileCubit(
        GetChefProfile(getIt<ChefRepository>()),
        ToggleFollowChef(getIt<ChefRepository>()),
        getIt<FavoritesCache>(),
      )..loadProfile(chefId),
      child: _ChefProfileView(chefId: chefId),
    );
  }
}

class _ChefProfileView extends StatelessWidget {
  const _ChefProfileView({required this.chefId});

  final String chefId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('بروفايل الطباخة'),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ChefProfileCubit, ChefProfileState>(
          builder: (context, state) {
            return switch (state) {
              ChefProfileInitial() || ChefProfileLoading() => const _ChefProfileLoadingSkeleton(),
              ChefProfileFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل بروفايل الطباخة',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<ChefProfileCubit>().loadProfile(chefId),
                ),
              ChefProfileLoaded(:final profile, :final searchQuery, :final selectedTag) =>
                _ChefProfileContent(
                  profile: profile,
                  searchQuery: searchQuery,
                  selectedTag: selectedTag,
                ),
            };
          },
        ),
      ),
    );
  }
}

class _ChefProfileContent extends StatelessWidget {
  const _ChefProfileContent({
    required this.profile,
    required this.searchQuery,
    required this.selectedTag,
  });

  final ChefProfileEntity profile;
  final String searchQuery;
  final String? selectedTag;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final tags = <String>{for (final meal in profile.meals) ...meal.tags}.toList();

    final filteredMeals = profile.meals.where((meal) {
      final matchesTag = selectedTag == null || meal.tags.contains(selectedTag);
      final matchesQuery = searchQuery.isEmpty ||
          meal.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTag && matchesQuery;
    }).toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.all(AppSpace.l),
          sliver: SliverToBoxAdapter(
            child: ChefProfileHeader(
              profile: profile,
              onToggleFollow: () => context.read<ChefProfileCubit>().toggleFollow(),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القائمة',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpace.m),
                TextField(
                  onChanged: (value) => context.read<ChefProfileCubit>().search(value),
                  decoration: InputDecoration(
                    hintText: 'ابحث في قائمة ${profile.name}...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: scheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      borderSide: BorderSide(color: scheme.outline),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.m),
                if (tags.isNotEmpty)
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: tags.length + 1,
                      separatorBuilder: (context, index) => const SizedBox(width: AppSpace.s),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MenuFilterChip(
                            label: 'الكل',
                            isSelected: selectedTag == null,
                            onTap: () => context.read<ChefProfileCubit>().selectTag(null),
                          );
                        }
                        final tag = tags[index - 1];
                        return MenuFilterChip(
                          label: tag,
                          isSelected: selectedTag == tag,
                          onTap: () => context.read<ChefProfileCubit>().selectTag(tag),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: AppSpace.m),
              ],
            ),
          ),
        ),
        if (filteredMeals.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyState(
              icon: Icons.restaurant_menu,
              title: 'لا توجد أطباق مطابقة',
              message: 'جرّبي كلمة بحث أو تصنيفًا آخر.',
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpace.l,
              vertical: AppSpace.m,
            ),
            sliver: SliverList.separated(
              itemCount: filteredMeals.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpace.m),
              itemBuilder: (context, index) {
                final meal = filteredMeals[index];
                return ChefMealListTile(
                  meal: meal,
                  onTap: () => context.push('/meal/${meal.id}'),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _ChefProfileLoadingSkeleton extends StatelessWidget {
  const _ChefProfileLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 320, borderRadius: 24),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 24, width: 120),
        SizedBox(height: AppSpace.m),
        LoadingSkeleton(height: 48, borderRadius: 12),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 108, borderRadius: 16),
        SizedBox(height: AppSpace.m),
        LoadingSkeleton(height: 108, borderRadius: 16),
        SizedBox(height: AppSpace.m),
        LoadingSkeleton(height: 108, borderRadius: 16),
      ],
    );
  }
}
