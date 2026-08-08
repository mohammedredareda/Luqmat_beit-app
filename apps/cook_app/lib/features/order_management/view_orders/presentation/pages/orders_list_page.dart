import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../bloc/view_orders_cubit.dart';
import '../bloc/view_orders_state.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_list_skeleton.dart';

/// CK-16 View My Orders — the four-filter (pending/preparing/done/rejected)
/// orders list. Root screen of the `/orders` shell branch (R-03: keeps the
/// bottom nav). Pixel-matched against the `my_orders` Stitch mockup: brand
/// top bar + big page heading (mirrors `ViewOffersPage`'s own `_Header`),
/// filled-pill filter chips (mirrors `ViewOffersPage`'s `_FilterChip` shape,
/// with this screen's own stronger solid-fill selected state per the mock).
class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ViewOrdersCubit>()..loadOrders(OrderStatus.pending),
      child: const _OrdersListView(),
    );
  }
}

class _OrdersListView extends StatefulWidget {
  const _OrdersListView();

  @override
  State<_OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<_OrdersListView> {
  int _filterIndex = 0;

  static const _filters = [
    OrderStatus.pending,
    OrderStatus.preparing,
    OrderStatus.done,
    OrderStatus.rejected,
  ];

  void _selectFilter(int index) {
    if (index == _filterIndex) return;
    setState(() => _filterIndex = index);
    context.read<ViewOrdersCubit>().loadOrders(_filters[index]);
  }

  void _refetchCurrentTab() {
    context.read<ViewOrdersCubit>().loadOrders(_filters[_filterIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luqmat Beit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: scheme.primary),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l10n.notificationsTitle,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, 0),
            child: _Header(l10n: l10n),
          ),
          const SizedBox(height: AppSpace.l),
          BlocBuilder<ViewOrdersCubit, ViewOrdersState>(
            builder: (context, state) {
              final countForSelected =
                  state.whenOrNull(loaded: (orders, hasMore, isLoadingMore) => orders.length);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
                child: _FilterRow(
                  l10n: l10n,
                  selectedIndex: _filterIndex,
                  countForSelected: countForSelected,
                  onSelected: _selectFilter,
                ),
              );
            },
          ),
          const SizedBox(height: AppSpace.m),
          Expanded(
            child: BlocBuilder<ViewOrdersCubit, ViewOrdersState>(
              builder: (context, state) => state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const OrdersListSkeleton(),
                loaded: (orders, hasMore, isLoadingMore) => _LoadedBody(
                  orders: orders,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                  currentFilterStatus: _filters[_filterIndex],
                  onChanged: _refetchCurrentTab,
                  onLoadMore: () => context.read<ViewOrdersCubit>().loadMore(),
                ),
                error: (exception) => _ErrorBody(
                  message: exception.message,
                  onRetry: _refetchCurrentTab,
                ),
              ),
            ),
          ),
        ],
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
          l10n.myOrdersTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 40,
                height: 48 / 40,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          l10n.myOrdersSubtitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.l10n,
    required this.selectedIndex,
    required this.countForSelected,
    required this.onSelected,
  });

  final AppLocalizations l10n;
  final int selectedIndex;
  final int? countForSelected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final labels = [
      l10n.ordersTabNew,
      l10n.ordersTabInProgress,
      l10n.ordersTabCompleted,
      l10n.ordersTabRejected,
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpace.s),
        itemBuilder: (context, index) => _OrderFilterChip(
          label: labels[index],
          selected: index == selectedIndex,
          count: index == selectedIndex ? countForSelected : null,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

/// Solid-fill selected state (per the `my_orders` mockup) — deliberately
/// stronger than `ViewOffersPage._FilterChip`'s lighter container-tint
/// selected state, since the two Stitch mockups treat "selected" filter
/// chips differently and this screen matches its own mockup exactly.
class _OrderFilterChip extends StatelessWidget {
  const _OrderFilterChip({
    required this.label,
    required this.selected,
    required this.count,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final int? count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected ? scheme.primary : scheme.surface,
      elevation: selected ? 1 : 0,
      shape: StadiumBorder(side: BorderSide(color: selected ? Colors.transparent : scheme.outline)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.s),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                    ),
              ),
              if (count != null) ...[
                const SizedBox(width: AppSpace.xs),
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: scheme.surface, shape: BoxShape.circle),
                  child: Text(
                    '$count',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({
    required this.orders,
    required this.hasMore,
    required this.isLoadingMore,
    required this.currentFilterStatus,
    required this.onChanged,
    required this.onLoadMore,
  });

  final List<OrderEntity> orders;
  final bool hasMore;
  final bool isLoadingMore;
  final OrderStatus currentFilterStatus;
  final VoidCallback onChanged;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (orders.isEmpty) {
      return _EmptyBody(currentFilterStatus: currentFilterStatus);
    }

    return PaginatedListView<OrderEntity>(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.m),
      items: orders,
      hasMore: hasMore,
      isLoadingMore: isLoadingMore,
      onLoadMore: onLoadMore,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpace.m),
      endOfListBuilder: (context) => _EndOfListMarker(status: currentFilterStatus),
      itemBuilder: (context, order, index) => OrderCard(
        order: order,
        orderNumberLabel: l10n.orderNumberLabel(order.id),
        moreItemsLabel: l10n.moreItemsLabel,
        currencySuffix: l10n.currencySuffix,
        detailsLabel: l10n.orderDetailsCta,
        acceptLabel: l10n.acceptOrderCta,
        onTap: () => _openDetails(context, order.id, onChanged),
        onAccept: () => _openDetails(context, order.id, onChanged),
      ),
    );
  }

  void _openDetails(BuildContext context, String orderId, VoidCallback onChanged) {
    context.push('/orders/$orderId').then((_) {
      if (context.mounted) onChanged();
    });
  }
}

class _EndOfListMarker extends StatelessWidget {
  const _EndOfListMarker({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final label = switch (status) {
      OrderStatus.pending => l10n.endOfListNewLabel,
      OrderStatus.preparing => l10n.endOfListInProgressLabel,
      OrderStatus.done || OrderStatus.delivering || OrderStatus.delivered =>
        l10n.endOfListCompletedLabel,
      OrderStatus.rejected || OrderStatus.cancelled || OrderStatus.returned =>
        l10n.endOfListRejectedLabel,
    };

    return Container(
      padding: const EdgeInsets.only(top: AppSpace.l),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outline, style: BorderStyle.solid)),
      ),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.currentFilterStatus});

  final OrderStatus currentFilterStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = currentFilterStatus;

    final (heading, body) = switch (status) {
      OrderStatus.pending => (l10n.emptyOrdersPendingHeading, l10n.emptyOrdersPendingBody),
      OrderStatus.preparing => (l10n.emptyOrdersPreparingHeading, l10n.emptyOrdersPreparingBody),
      OrderStatus.done || OrderStatus.delivering || OrderStatus.delivered =>
        (l10n.emptyOrdersDoneHeading, l10n.emptyOrdersDoneBody),
      OrderStatus.rejected || OrderStatus.cancelled || OrderStatus.returned =>
        (l10n.emptyOrdersRejectedHeading, l10n.emptyOrdersRejectedBody),
    };

    return Center(
      child: SingleChildScrollView(
        child: EmptyState(
          icon: Icons.receipt_long,
          title: heading,
          message: body,
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
            OutlinedButton(onPressed: onRetry, child: Text(l10n.retryLabel)),
          ],
        ),
      ),
    );
  }
}
