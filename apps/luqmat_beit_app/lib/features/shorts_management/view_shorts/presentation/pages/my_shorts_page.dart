import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/domain/entities/short_management_entity.dart';
import '../../../shared/presentation/widgets/delete_short_confirmation.dart';
import '../../../shared/presentation/widgets/short_player_dialog.dart';
import '../bloc/view_shorts_cubit.dart';
import '../bloc/view_shorts_state.dart';
import '../widgets/my_shorts_gallery_skeleton.dart';
import '../widgets/short_gallery_card.dart';

/// Cook-side "My Shorts" gallery — mockup `_4`.
class MyShortsPage extends StatelessWidget {
  const MyShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ViewShortsCubit>()..load(),
      child: const _MyShortsView(),
    );
  }
}

void _onAddPressed(BuildContext context) {
  context.push('/cook/shorts/create').then((changed) {
    if (changed == true && context.mounted) context.read<ViewShortsCubit>().load();
  });
}

class _MyShortsView extends StatelessWidget {
  const _MyShortsView();

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
      // Title + subtitle are persistent chrome (mirrors `ViewOffersPage`/
      // `ViewMenuPage`'s `_Header`) — only the body below swaps between
      // skeleton/loaded/error, so the title stays visible through every
      // state, loading included.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, 0),
            child: _Header(l10n: l10n),
          ),
          const SizedBox(height: AppSpace.xl),
          Expanded(
            child: BlocBuilder<ViewShortsCubit, ViewShortsState>(
              builder: (context, state) => state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const MyShortsGallerySkeleton(),
                loaded: (items, hasMore, isLoadingMore) => _LoadedBody(
                  items: items,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                  onLoadMore: () => context.read<ViewShortsCubit>().loadMore(),
                ),
                error: (exception) => _ErrorBody(message: exception.message),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddPressed(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
          l10n.myShortsTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 40,
                height: 48 / 40,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          l10n.myShortsBannerBody,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _LoadedBody extends StatefulWidget {
  const _LoadedBody({
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final List<ShortManagementEntity> items;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody> {
  bool _onScrollNotification(ScrollNotification notification) {
    if (!widget.hasMore || widget.isLoadingMore) return false;
    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent * PaginationConstants.prefetchThreshold) {
      widget.onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Captured once from this widget's own stable context — not re-derived
    // per grid item inside the delete closure below, since a grid item's
    // own BuildContext can be disposed by SliverGrid's recycling while the
    // delete's network round-trip is in flight (a real possibility now
    // that delete is a genuine request, not the old instant fake-cache
    // write), which would silently drop the reload call below and leave a
    // deleted card stuck on screen. A Cubit reference itself has no such
    // lifecycle sensitivity.
    final viewShortsCubit = context.read<ViewShortsCubit>();

    if (widget.items.isEmpty && !widget.hasMore) {
      return SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
        child: EmptyState(
          icon: Icons.movie_creation_outlined,
          title: l10n.emptyShortsHeading,
          message: l10n.emptyShortsBody,
          actionLabel: l10n.createShortTitle,
          onAction: () => _onAddPressed(context),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpace.m,
                crossAxisSpacing: AppSpace.m,
                childAspectRatio: 9 / 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final short = widget.items[index];
                  return ShortGalleryCard(
                    short: short,
                    onTap: () => showShortPlayerDialog(
                      context,
                      videoUrl: short.videoUrl,
                      description: short.description,
                      viewCount: short.viewCount,
                    ),
                    onDelete: () => showDeleteShortConfirmation(
                      context,
                      shortId: short.id,
                      // Re-fetches page 1 from the real server after a
                      // successful delete instead of only removing the
                      // card from local state — guarantees the grid
                      // matches the backend regardless of any local-state
                      // edge case, at the cost of one extra request.
                      onDeleted: () => viewShortsCubit.load(),
                    ),
                  );
                },
                childCount: widget.items.length,
              ),
            ),
          ),
          if (widget.isLoadingMore)
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: AppSpace.l),
              sliver: SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
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
              onPressed: () => context.read<ViewShortsCubit>().load(),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
