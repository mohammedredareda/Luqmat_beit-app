import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../orders/domain/usecases/confirm_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/update_cart_item_quantity.dart';
import '../cubit/shopping_cart_cubit.dart';
import '../cubit/shopping_cart_state.dart';
import '../widgets/cart_item_row.dart';
import '../widgets/cart_summary_footer.dart';

/// CU-15/CU-16: view + manage the shopping cart. No bottom nav bar on
/// this screen per the approved mockup.
class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = getIt<CartRepository>();
    return BlocProvider(
      create: (_) => ShoppingCartCubit(
        GetCartItems(repository),
        UpdateCartItemQuantity(repository),
        RemoveCartItem(repository),
        repository,
        ConfirmOrder(getIt()),
      )..loadCart(),
      child: const _ShoppingCartView(),
    );
  }
}

class _ShoppingCartView extends StatelessWidget {
  const _ShoppingCartView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('السلة 🛒'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
          builder: (context, state) {
            return switch (state) {
              ShoppingCartInitial() || ShoppingCartLoading() => const _CartLoadingSkeleton(),
              ShoppingCartFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل السلة',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<ShoppingCartCubit>().loadCart(),
                ),
              ShoppingCartEmpty() => EmptyState(
                  icon: Icons.shopping_cart_outlined,
                  title: 'سلتك فارغة',
                  message: 'أضف أطباقاً شهية من صفحة الأكلات لتظهر هنا.',
                  actionLabel: 'تصفح الأكلات',
                  onAction: () => context.go('/'),
                ),
              ShoppingCartLoaded(:final cart, :final deliveryFee) =>
                _CartContent(cart: cart, deliveryFee: deliveryFee),
            };
          },
        ),
      ),
      backgroundColor: scheme.surfaceContainerLowest,
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.cart, required this.deliveryFee});

  final CartEntity cart;
  final double deliveryFee;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShoppingCartCubit>();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            children: [
              for (final item in cart.mealItems) ...[
                CartItemRow(
                  item: item,
                  onQuantityChanged: (quantity) => cubit.changeQuantity(item.id, quantity),
                  onRemove: () async {
                    final confirmed = await ConfirmationDialog.show(
                      context,
                      title: 'إزالة الصنف',
                      message: 'هل تريد إزالة "${item.mealName}" من السلة؟',
                      confirmLabel: 'إزالة',
                      isDestructive: true,
                    );
                    if (confirmed) {
                      // ignore: use_build_context_synchronously
                      cubit.removeItem(item.id);
                    }
                  },
                ),
                const Divider(height: AppSpace.xl),
              ],
              // CU-15: offer items and "من نصيبك" returned-meal items are
              // grouped by type, not by chef — no quantity stepper on
              // returned-meal lines beyond the limited stock claimed.
              for (final item in cart.offerItems) ...[
                _SimpleCartRow(
                  title: item.offerName,
                  subtitle: 'عرض ×${item.quantity}',
                  value: item.subtotal,
                  onRemove: () => cubit.removeItem(item.id),
                ),
                const Divider(height: AppSpace.xl),
              ],
              if (cart.returnedMealItems.isNotEmpty) ...[
                Text('من نصيبك', style: textTheme.titleMedium),
                const SizedBox(height: AppSpace.s),
                for (final item in cart.returnedMealItems) ...[
                  _SimpleCartRow(
                    title: item.mealName,
                    subtitle: 'كمية ×${item.quantity}',
                    value: item.subtotal,
                    onRemove: () => cubit.removeItem(item.id),
                  ),
                  const Divider(height: AppSpace.xl),
                ],
              ],
            ],
          ),
        ),
        CartSummaryFooter(
          subtotal: cart.itemsTotal,
          deliveryFee: deliveryFee,
          onCheckout: () async {
            final orderId = await cubit.checkout();
            if (orderId != null && context.mounted) {
              context.push('/order-confirmation/$orderId');
            }
          },
        ),
      ],
    );
  }
}

class _SimpleCartRow extends StatelessWidget {
  const _SimpleCartRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onRemove,
  });

  final String title;
  final String subtitle;
  final double value;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: AppSpace.xs),
              Text(subtitle, style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} AED',
          style: textTheme.titleMedium?.copyWith(color: scheme.primary),
        ),
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.delete_outline, color: scheme.error),
          tooltip: 'إزالة',
        ),
      ],
    );
  }
}

class _CartLoadingSkeleton extends StatelessWidget {
  const _CartLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 96, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 96, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 96, borderRadius: 16),
      ],
    );
  }
}
