import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../../../shared/presentation/widgets/order_items_dialog.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../domain/usecases/get_in_progress_orders.dart';
import '../cubit/my_orders_cubit.dart';
import '../cubit/my_orders_state.dart';

/// CU-31 — in-progress orders list (U09 mockup, which has the bottom nav).
class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyOrdersCubit(GetInProgressOrders(getIt()))..loadOrders(),
      child: const _MyOrdersView(),
    );
  }
}

class _MyOrdersView extends StatelessWidget {
  const _MyOrdersView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MyOrdersCubit, MyOrdersState>(
          builder: (context, state) {
            return switch (state) {
              MyOrdersInitial() ||
              MyOrdersLoading() =>
                const _MyOrdersLoadingSkeleton(),
              MyOrdersFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل الطلبات',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<MyOrdersCubit>().loadOrders(),
                ),
              MyOrdersLoaded(:final orders) when orders.isEmpty => EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'لا توجد طلبات حالياً',
                  message: 'عند إتمام طلب جديد سيظهر هنا.',
                  actionLabel: 'تصفح الأكل',
                  onAction: () => context.go('/'),
                ),
              MyOrdersLoaded(:final orders) => _MyOrdersList(orders: orders),
            };
          },
        ),
      ),
      bottomNavigationBar:
          const CustomerBottomNav(currentTab: CustomerNavTab.orders),
      backgroundColor: scheme.surface,
    );
  }
}

class _MyOrdersList extends StatelessWidget {
  const _MyOrdersList({required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpace.m),
      itemBuilder: (context, index) => _OrderCard(order: orders[index]),
    );
  }
}

/// Tapping opens [showOrderItemsDialog] with this order's items/quantities
/// and cook name — there's no dedicated order-details screen to push to.
class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currencySuffix = AppLocalizations.of(context)!.currencySuffix;
    final isRejected = order.status == OrderStatus.rejected;

    return Opacity(
      opacity: isRejected ? 0.75 : 1,
      child: InkWell(
        onTap: () => showOrderItemsDialog(context, order: order),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpace.m),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.surfaceContainerHighest),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'طلب #${order.id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: AppSpace.s),
                  OrderStatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: AppSpace.s),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: scheme.onSurfaceVariant),
                  const SizedBox(width: AppSpace.xs),
                  Text(
                    order.cookName,
                    style: textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.xs),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: scheme.onSurfaceVariant),
                  const SizedBox(width: AppSpace.xs),
                  Text(
                    _formatDate(order.createdAt),
                    style: textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.s),
              Text(
                '${order.grandTotal.toStringAsFixed(0)} $currencySuffix',
                style: textTheme.titleMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final y = date.year.toString();
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y/$m/$d';
  }
}

class _MyOrdersLoadingSkeleton extends StatelessWidget {
  const _MyOrdersLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpace.m),
      itemBuilder: (context, index) =>
          const LoadingSkeleton(height: 96, borderRadius: 16),
    );
  }
}
