import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/widgets/delete_meal_confirmation.dart';
import '../bloc/stop_selling_cubit.dart';
import '../bloc/view_menu_cubit.dart';
import '../bloc/view_menu_state.dart';
import '../widgets/cook_meal_card.dart';
import '../widgets/sale_status_card.dart';
import '../widgets/view_menu_skeleton.dart';

/// CK-06 View My Menu + CK-10 Stop Selling — the cook's dashboard.
class ViewMenuPage extends StatelessWidget {
  const ViewMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ViewMenuCubit>()..loadMenu()),
        BlocProvider(create: (_) => getIt<StopSellingCubit>()),
      ],
      child: const _ViewMenuView(),
    );
  }
}

class _ViewMenuView extends StatelessWidget {
  const _ViewMenuView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luqmat Beit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/cook/notifications'),
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l10n.notificationsTitle,
          ),
        ],
      ),
      // "My List" + subtitle are persistent chrome (mirrors
      // `ViewOffersPage`'s `_Header`/filter-tabs) — only the content below
      // swaps between skeleton/loaded/error, so the title never disappears
      // during a fetch.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, 0),
            child: _Header(l10n: l10n),
          ),
          const SizedBox(height: AppSpace.xl),
          Expanded(
            child: BlocBuilder<ViewMenuCubit, ViewMenuState>(
              builder: (context, state) => state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const ViewMenuSkeleton(),
                loaded: (meals, isSellingPaused, hasMore, isLoadingMore) => _LoadedBody(
                  meals: meals,
                  isSellingPaused: isSellingPaused,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                ),
                error: (exception) => _ErrorBody(message: exception.message),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Unlike edit/delete, creation can't be reflected optimistically:
        // the backend's create response carries no meal data at all (see
        // MealRemoteDataSource.createMeal's comment) — no server id, no
        // hosted image URL — so there's nothing accurate to hand the cubit
        // without asking the server again.
        onPressed: () => context.push('/cook/meals/create').then((_) {
          if (context.mounted) context.read<ViewMenuCubit>().loadMenu();
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({
    required this.meals,
    required this.isSellingPaused,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final List<MealEntity> meals;
  final bool isSellingPaused;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
          child: SaleStatusCard(
            isSellingPaused: isSellingPaused,
            onSellingStatusChanged: () => context.read<ViewMenuCubit>().loadMenu(),
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        Expanded(
          child: meals.isEmpty
              ? SingleChildScrollView(
                  child: EmptyState(
                    icon: Icons.soup_kitchen,
                    title: l10n.emptyMenuHeading,
                    message: l10n.emptyMenuBody,
                    actionLabel: l10n.addMealCta,
                    onAction: () => context.push('/cook/meals/create').then((_) {
                      if (context.mounted) context.read<ViewMenuCubit>().loadMenu();
                    }),
                  ),
                )
              : PaginatedListView<MealEntity>(
                  padding: const EdgeInsets.fromLTRB(AppSpace.l, 0, AppSpace.l, AppSpace.l),
                  items: meals,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                  onLoadMore: () => context.read<ViewMenuCubit>().loadMore(),
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpace.m),
                  itemBuilder: (context, meal, index) => CookMealCard(
                    meal: meal,
                    isActive: meal.computeIsActive(
                      withinAvailabilityWindow: true,
                      cookIsSellingPaused: isSellingPaused,
                    ),
                    outOfStockLabel: l10n.outOfStockBadge,
                    startingFromLabel: l10n.startingFromLabel,
                    onEdit: () => context.push<Object>('/cook/meals/${meal.id}/edit').then((result) {
                      if (!context.mounted) return;
                      final cubit = context.read<ViewMenuCubit>();
                      if (result is MealEntity) {
                        cubit.replaceMeal(result);
                      } else if (result is MealDeleted) {
                        cubit.removeMeal(result.mealId);
                      }
                    }),
                    onDelete: () => showDeleteMealConfirmation(
                      context,
                      mealId: meal.id,
                      onDeleted: () => context.read<ViewMenuCubit>().removeMeal(meal.id),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.myMenuTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 40,
                height: 48 / 40,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          l10n.myMenuSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: AppSpace.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.l),
            OutlinedButton(
              onPressed: () => context.read<ViewMenuCubit>().loadMenu(),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
