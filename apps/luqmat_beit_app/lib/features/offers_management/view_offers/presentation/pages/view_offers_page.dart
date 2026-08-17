import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/widgets/offer_discount_card.dart';
import '../../../shared/presentation/widgets/offer_discount_delete_confirmation.dart';
import '../../../shared/presentation/widgets/select_offer_type_sheet.dart';
import '../../domain/entities/offer_feed_filter.dart';
import '../../domain/entities/offer_feed_item_entity.dart';
import '../bloc/view_offers_cubit.dart';
import '../bloc/view_offers_state.dart';
import '../widgets/view_offers_skeleton.dart';

/// CK-11 View Offers & Discounts.
class ViewOffersPage extends StatelessWidget {
  const ViewOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ViewOffersCubit>()..load(),
      child: const _ViewOffersView(),
    );
  }
}

Future<void> _onAddPressed(BuildContext context) async {
  final choice = await showSelectOfferTypeSheet(context);
  if (choice == null || !context.mounted) return;
  final route = choice == OfferTypeChoice.offer ? '/cook/offers/create' : '/cook/discounts/create';
  // Create pages only `pop(true)` on an actual successful save (see
  // `CreateOfferPage`/`CreateDiscountPage`'s success listeners) — a plain
  // Cancel/back pops `null`, so this skips the full skeleton-flash reload
  // when nothing actually changed.
  context.push(route).then((changed) {
    if (changed == true && context.mounted) context.read<ViewOffersCubit>().load();
  });
}

class _ViewOffersView extends StatefulWidget {
  const _ViewOffersView();

  @override
  State<_ViewOffersView> createState() => _ViewOffersViewState();
}

class _ViewOffersViewState extends State<_ViewOffersView> {
  OfferFeedFilter _filter = OfferFeedFilter.all;

  void _selectFilter(OfferFeedFilter filter) {
    if (filter == _filter) return;
    setState(() => _filter = filter);
    context.read<ViewOffersCubit>().load(filter: filter);
  }

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
      // Header + filter tabs are persistent chrome (mirrors
      // `OrdersListPage`'s `_Header`/`_FilterRow`) — only the body content
      // below swaps between skeleton/loaded/error, so the "My Offers"
      // title and tabs stay visible through every state, loading included.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, 0),
            child: _Header(l10n: l10n),
          ),
          const SizedBox(height: AppSpace.l),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(
                    label: l10n.filterAllLabel,
                    selected: _filter == OfferFeedFilter.all,
                    onTap: () => _selectFilter(OfferFeedFilter.all),
                  ),
                  const SizedBox(width: AppSpace.s),
                  _FilterChip(
                    label: l10n.filterActiveLabel,
                    selected: _filter == OfferFeedFilter.active,
                    onTap: () => _selectFilter(OfferFeedFilter.active),
                  ),
                  const SizedBox(width: AppSpace.s),
                  _FilterChip(
                    label: l10n.filterExpiredLabel,
                    selected: _filter == OfferFeedFilter.expired,
                    onTap: () => _selectFilter(OfferFeedFilter.expired),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpace.l),
          Expanded(
            child: BlocBuilder<ViewOffersCubit, ViewOffersState>(
              builder: (context, state) => state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const ViewOffersSkeleton(),
                loaded: (items, hasMore, isLoadingMore) => _LoadedBody(
                  items: items,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                  filter: _filter,
                  onLoadMore: () => context.read<ViewOffersCubit>().loadMore(),
                ),
                error: (exception) => _ErrorBody(message: exception.message),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.filter,
    required this.onLoadMore,
  });

  final List<OfferFeedItemEntity> items;
  final bool hasMore;
  final bool isLoadingMore;
  final OfferFeedFilter filter;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Nothing exists at all (not just "no matches for this filter") —
    // only reliably knowable on the unfiltered tab once it's fully loaded.
    final isTrulyEmpty = filter == OfferFeedFilter.all && items.isEmpty && !hasMore;

    return isTrulyEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
            child: EmptyState(
              icon: Icons.local_offer_outlined,
              title: l10n.emptyOffersHeading,
              message: l10n.emptyOffersBody,
              actionLabel: l10n.addOfferOrDiscountCta,
              onAction: () => _onAddPressed(context),
            ),
          )
        : PaginatedListView<OfferFeedItemEntity>(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: 0),
            items: items,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            onLoadMore: onLoadMore,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpace.l),
            endOfListBuilder: (context) => _AddNewTile(l10n: l10n),
            itemBuilder: (context, item, index) => switch (item) {
              OfferFeedDiscountItem(
                :final id,
                :final rawId,
                :final title,
                :final description,
                :final expiryTime,
              ) =>
                DiscountCard(
                  title: title,
                  description: description,
                  expiryTime: expiryTime,
                  onEdit: () => context.push('/cook/discounts/$rawId/edit').then((changed) {
                    if (changed == true && context.mounted) {
                      context.read<ViewOffersCubit>().load();
                    }
                  }),
                  onDelete: () => showDeleteDiscountConfirmation(
                    context,
                    discountId: rawId,
                    onDeleted: () => context.read<ViewOffersCubit>().removeItem(id),
                  ),
                ),
              OfferFeedOfferItem(
                :final id,
                :final rawId,
                :final title,
                :final description,
                :final expiryTime,
              ) =>
                OfferCard(
                  title: title,
                  description: description,
                  expiryTime: expiryTime,
                  onEdit: () => context.push('/cook/offers/$rawId/edit').then((changed) {
                    if (changed == true && context.mounted) {
                      context.read<ViewOffersCubit>().load();
                    }
                  }),
                  onDelete: () => showDeleteOfferConfirmation(
                    context,
                    offerId: rawId,
                    onDeleted: () => context.read<ViewOffersCubit>().removeItem(id),
                  ),
                ),
            },
          );
  }
}

class _AddNewTile extends StatelessWidget {
  const _AddNewTile({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.l),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () => _onAddPressed(context),
        child: Container(
          constraints: const BoxConstraints(minHeight: 140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outline, width: 2, style: BorderStyle.solid),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpace.s),
                Text(
                  l10n.addOfferOrDiscountCta,
                  style: textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ),
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
          l10n.offersTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 40,
                height: 48 / 40,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          l10n.offersSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.l),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => _onAddPressed(context),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            icon: const Icon(Icons.add),
            label: Text(l10n.addOfferOrDiscountCta),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected ? AppColors.sumacContainer : scheme.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? scheme.primary.withValues(alpha: 0.2) : scheme.outline),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.s),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                ),
          ),
        ),
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
              onPressed: () => context.read<ViewOffersCubit>().load(),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
