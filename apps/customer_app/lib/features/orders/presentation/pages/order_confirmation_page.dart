import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_order_by_id.dart';
import '../cubit/order_confirmation_cubit.dart';
import '../cubit/order_confirmation_state.dart';
import '../widgets/order_line_item_row.dart';

/// CU-18 — shown right after checkout succeeds.
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OrderConfirmationCubit(GetOrderById(getIt()))..loadOrder(orderId),
      child: _OrderConfirmationView(orderId: orderId),
    );
  }
}

class _OrderConfirmationView extends StatelessWidget {
  const _OrderConfirmationView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderConfirmationCubit, OrderConfirmationState>(
          builder: (context, state) {
            return switch (state) {
              OrderConfirmationInitial() || OrderConfirmationLoading() =>
                const _ConfirmationLoadingSkeleton(),
              OrderConfirmationFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل تفاصيل الطلب',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () =>
                      context.read<OrderConfirmationCubit>().loadOrder(orderId),
                ),
              OrderConfirmationLoaded(:final order) =>
                _ConfirmationContent(order: order),
            };
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.l),
        decoration: BoxDecoration(
          color: scheme.surface,
          border: BorderDirectional(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: ElevatedButton.icon(
            onPressed: () => context.go('/orders'),
            icon: const Icon(Icons.check),
            label: const Text('إتمام الطلب'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmationContent extends StatelessWidget {
  const _ConfirmationContent({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final allItems = order.subOrders.expand((sub) => sub.items).toList();

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: AppSpace.s),
                child: Text('الفاتورة', style: textTheme.titleLarge),
              ),
              Divider(color: scheme.outlineVariant),
              for (final item in allItems) OrderLineItemRow(item: item),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('أجرة التوصيل', style: textTheme.bodyLarge),
                  Text(
                    order.deliveryFee.toStringAsFixed(0),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
              if (order.discountAmount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الخصم', style: TextStyle(color: AppColors.success)),
                    Text(
                      '-${order.discountAmount.toStringAsFixed(0)}',
                      style: TextStyle(color: AppColors.success),
                    ),
                  ],
                ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المجموع الكلي',
                    style: textTheme.titleMedium?.copyWith(color: scheme.primary),
                  ),
                  Text(
                    '${order.grandTotal.toStringAsFixed(0)} ₪',
                    style: textTheme.titleMedium?.copyWith(color: scheme.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.l),
        _Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, color: scheme.primary),
                  const SizedBox(width: AppSpace.s),
                  Text('الوقت المتوقع', style: textTheme.titleLarge),
                ],
              ),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.m,
                  vertical: AppSpace.xs,
                ),
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  '60 — 75 دقيقة',
                  style: TextStyle(
                    color: scheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.l),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, color: scheme.primary),
                  const SizedBox(width: AppSpace.s),
                  Text('عنوان التوصيل', style: textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: AppSpace.s),
              Text(order.deliveryAddress, style: textTheme.bodyMedium),
              const SizedBox(height: AppSpace.s),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: scheme.onSurfaceVariant),
                  const SizedBox(width: AppSpace.xs),
                  Expanded(
                    child: Text(
                      'يجب أن يقع الموعد ضمن أوقات توفر الطباخة',
                      style: textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: child,
    );
  }
}

class _ConfirmationLoadingSkeleton extends StatelessWidget {
  const _ConfirmationLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 180, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 64, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 120, borderRadius: 16),
      ],
    );
  }
}
