import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_order_history.dart';
import '../cubit/order_history_cubit.dart';
import '../cubit/order_history_state.dart';
import '../widgets/order_history_card.dart';

/// CU-20/CU-21: past (completed/rejected) orders. Reached by pushing from
/// elsewhere (e.g. the Profile tab) — not one of the 5 bottom-nav tabs, so
/// this page has no CustomerBottomNav and a normal back-arrow AppBar.
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryCubit(GetOrderHistory(getIt()))..loadOrderHistory(),
      child: const _OrderHistoryView(),
    );
  }
}

class _OrderHistoryView extends StatelessWidget {
  const _OrderHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الطلبات')),
      body: SafeArea(
        child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            return switch (state) {
              OrderHistoryInitial() || OrderHistoryLoading() => const _OrderHistoryLoadingSkeleton(),
              OrderHistoryFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل سجل الطلبات',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<OrderHistoryCubit>().loadOrderHistory(),
                ),
              OrderHistoryLoaded(:final orders) when orders.isEmpty => const EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'لا يوجد طلبات سابقة',
                  message: 'كل طلب تكمله هيظهر هنا عشان تقدر تطلبه تاني بسهولة.',
                ),
              OrderHistoryLoaded(:final orders) => _OrderHistoryList(orders: orders),
            };
          },
        ),
      ),
    );
  }
}

class _OrderHistoryList extends StatelessWidget {
  const _OrderHistoryList({required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpace.l),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderHistoryCard(
          order: order,
          onTap: () => context.push('/invoice/${order.id}'),
        );
      },
    );
  }
}

class _OrderHistoryLoadingSkeleton extends StatelessWidget {
  const _OrderHistoryLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpace.l),
      itemBuilder: (_, _) => const LoadingSkeleton(height: 96, borderRadius: 16),
    );
  }
}
