import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_order_by_id.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../widgets/order_line_item_row.dart';

/// CU-19 — invoice for a past order. No bottom nav: a transactional,
/// focused screen (matches U08 mockup, which has no `<nav>`).
class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvoiceCubit(GetOrderById(getIt()))..loadOrder(orderId),
      child: _InvoiceView(orderId: orderId),
    );
  }
}

class _InvoiceView extends StatelessWidget {
  const _InvoiceView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفاتورة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<InvoiceCubit, InvoiceState>(
          builder: (context, state) {
            return switch (state) {
              InvoiceInitial() ||
              InvoiceLoading() =>
                const _InvoiceLoadingSkeleton(),
              InvoiceFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل الفاتورة',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () =>
                      context.read<InvoiceCubit>().loadOrder(orderId),
                ),
              InvoiceLoaded(:final order) => _InvoiceContent(order: order),
            };
          },
        ),
      ),
    );
  }
}

class _InvoiceContent extends StatelessWidget {
  const _InvoiceContent({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final lineItemRows = [
      ...order.mealItems.map((item) => OrderLineItemRow.meal(item)),
      ...order.offerItems.map((item) => OrderLineItemRow.offer(item)),
      ...order.returnedMealItems
          .map((item) => OrderLineItemRow.returnedMeal(item)),
    ];

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: [
        Column(
          children: [
            Text('طلب #${order.id}', style: textTheme.headlineSmall),
            const SizedBox(height: AppSpace.xs),
            Text(
              _formatDate(order.createdAt),
              style: textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpace.l),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تفاصيل الطلب', style: textTheme.titleLarge),
              const SizedBox(height: AppSpace.s),
              for (final row in lineItemRows)
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: AppSpace.xs),
                  child: row,
                ),
              const SizedBox(height: AppSpace.s),
              _BreakdownRow(label: 'المجموع الفرعي', value: order.itemsTotal),
              if (order.discountAmount > 0)
                _BreakdownRow(
                  label: 'الخصم',
                  value: -order.discountAmount,
                  color: AppColors.success,
                ),
              _BreakdownRow(label: 'أجرة التوصيل', value: order.deliveryFee),
              const SizedBox(height: AppSpace.s),
              const _DashedDivider(),
              const SizedBox(height: AppSpace.s),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي', style: textTheme.titleLarge),
                  Text(
                    '${order.grandTotal.toStringAsFixed(0)} ${AppLocalizations.of(context)!.currencySuffix}',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: scheme.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('جارٍ تجهيز الفاتورة للمشاركة...')),
            );
          },
          icon: const Icon(Icons.share),
          label: const Text('تحميل / مشاركة الفاتورة'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            side: BorderSide(color: scheme.primary),
            foregroundColor: scheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final h = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? 'م' : 'ص';
    return '$d/$m/${date.year} — $h:${date.minute.toString().padLeft(2, '0')} $period';
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value, this.color});

  final String label;
  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final resolvedColor = color ?? scheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: resolvedColor)),
          Text(value.toStringAsFixed(0),
              style: TextStyle(color: resolvedColor)),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 6.0;
          const dashSpace = 4.0;
          final dashCount =
              (constraints.maxWidth / (dashWidth + dashSpace)).floor();
          return Row(
            children: List.generate(
              dashCount,
              (_) => Padding(
                padding: const EdgeInsetsDirectional.only(end: dashSpace),
                child: Container(
                    width: dashWidth,
                    height: 1.5,
                    color: scheme.outlineVariant),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InvoiceLoadingSkeleton extends StatelessWidget {
  const _InvoiceLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 40, width: 200),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 260, borderRadius: 16),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 52, borderRadius: 16),
      ],
    );
  }
}
