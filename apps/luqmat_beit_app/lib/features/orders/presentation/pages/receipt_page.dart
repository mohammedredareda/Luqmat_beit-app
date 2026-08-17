import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_order_by_id.dart';
import '../cubit/order_confirmation_cubit.dart';
import '../cubit/order_confirmation_state.dart';

/// Shown right after a successful `/order/confirm` call — "مشاركة الفاتورة
/// أو التحميل". No share/PDF plugin is in this app's dependencies yet, so
/// "مشاركة" copies the invoice to the clipboard (paste it into whichever
/// app the customer wants to send it through) and "تحميل" saves it as a
/// plain-text file under the app's documents directory — both real,
/// working actions, just not an OS share-sheet or an actual PDF.
class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderConfirmationCubit(GetOrderById(getIt()))..loadOrder(orderId),
      child: _ReceiptView(orderId: orderId),
    );
  }
}

class _ReceiptView extends StatelessWidget {
  const _ReceiptView({required this.orderId});

  final String orderId;

  String _invoiceText(OrderEntity order) {
    final buffer = StringBuffer('فاتورة الطلب #$orderId\n\n');
    for (final item in order.mealItems) {
      buffer.writeln('${item.mealName} ×${item.quantity} — ${item.subtotal.toStringAsFixed(0)}');
    }
    for (final item in order.offerItems) {
      buffer.writeln('${item.offerName} ×${item.quantity} — ${item.subtotal.toStringAsFixed(0)}');
    }
    buffer.writeln('أجرة التوصيل: ${order.deliveryFee.toStringAsFixed(0)}');
    buffer.writeln('المجموع الكلي: ${order.grandTotal.toStringAsFixed(0)} ₪');
    return buffer.toString();
  }

  Future<void> _share(BuildContext context, OrderEntity order) async {
    await Clipboard.setData(ClipboardData(text: _invoiceText(order)));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ تفاصيل الفاتورة — الصقها بالتطبيق يلي بدك ترسلها فيه.')),
    );
  }

  Future<void> _download(BuildContext context, OrderEntity order) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/invoice-$orderId.txt');
      await file.writeAsString(_invoiceText(order));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('تم حفظ الفاتورة: ${file.path}')));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تعذر حفظ الفاتورة.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('تم تأكيد الطلب')),
      body: SafeArea(
        child: BlocBuilder<OrderConfirmationCubit, OrderConfirmationState>(
          builder: (context, state) {
            return switch (state) {
              OrderConfirmationInitial() ||
              OrderConfirmationLoading() =>
                const Center(child: CircularProgressIndicator()),
              OrderConfirmationFailure() => Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(AppSpace.l),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 80, color: AppColors.success),
                        const SizedBox(height: AppSpace.l),
                        Text('تم تأكيد طلبك بنجاح!', style: textTheme.titleLarge),
                        const SizedBox(height: AppSpace.s),
                        Text('رقم الطلب: $orderId', style: textTheme.bodyMedium),
                        const SizedBox(height: AppSpace.xl),
                        ElevatedButton(
                          onPressed: () => context.go('/orders'),
                          child: const Text('عرض طلباتي'),
                        ),
                      ],
                    ),
                  ),
                ),
              OrderConfirmationLoaded(:final order) => Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(AppSpace.l),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 80, color: AppColors.success),
                        const SizedBox(height: AppSpace.l),
                        Text('تم تأكيد طلبك بنجاح!', style: textTheme.titleLarge),
                        const SizedBox(height: AppSpace.s),
                        Text(
                          'المجموع الكلي: ${order.grandTotal.toStringAsFixed(0)} ₪',
                          style: textTheme.bodyMedium?.copyWith(color: scheme.primary),
                        ),
                        const SizedBox(height: AppSpace.xl),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _share(context, order),
                            icon: const Icon(Icons.share),
                            label: const Text('مشاركة الفاتورة'),
                          ),
                        ),
                        const SizedBox(height: AppSpace.m),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _download(context, order),
                            icon: const Icon(Icons.download),
                            label: const Text('تحميل الفاتورة'),
                          ),
                        ),
                        const SizedBox(height: AppSpace.l),
                        TextButton(
                          onPressed: () => context.go('/orders'),
                          child: const Text('عرض طلباتي'),
                        ),
                      ],
                    ),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
