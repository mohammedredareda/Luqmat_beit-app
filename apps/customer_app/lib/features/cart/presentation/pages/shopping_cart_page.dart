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
              ShoppingCartLoaded(:final items, :final subtotal, :final deliveryFee) =>
                _CartContent(items: items, subtotal: subtotal, deliveryFee: deliveryFee),
            };
          },
        ),
      ),
      backgroundColor: scheme.surfaceContainerLowest,
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
  });

  final List<CartItemEntity> items;
  final double subtotal;
  final double deliveryFee;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShoppingCartCubit>();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            itemCount: items.length,
            separatorBuilder: (_, _) => const Divider(height: AppSpace.xl),
            itemBuilder: (context, index) {
              final item = items[index];
              return CartItemRow(
                item: item,
                onQuantityChanged: (quantity) => cubit.changeQuantity(item.id, quantity),
                onSellingOptionChanged: (sellingOptionId) =>
                    cubit.changeSellingOption(item.id, sellingOptionId),
                onRemove: () async {
                  final confirmed = await ConfirmationDialog.show(
                    context,
                    title: 'إزالة الصنف',
                    message: 'هل تريد إزالة "${item.meal.name}" من السلة؟',
                    confirmLabel: 'إزالة',
                    isDestructive: true,
                  );
                  if (confirmed) {
                    // ignore: use_build_context_synchronously
                    cubit.removeItem(item.id);
                  }
                },
              );
            },
          ),
        ),
        CartSummaryFooter(
          subtotal: subtotal,
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
