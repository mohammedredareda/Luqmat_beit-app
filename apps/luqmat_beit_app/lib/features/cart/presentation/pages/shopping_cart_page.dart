import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../../orders/domain/usecases/confirm_returned_meals_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/update_cart_item_quantity.dart';
import '../cubit/shopping_cart_cubit.dart';
import '../cubit/shopping_cart_state.dart';
import '../widgets/cart_item_row.dart';

/// CU-15/CU-16: view + manage the shopping cart. No bottom nav bar on
/// this screen per the approved mockup. A customer can have items from
/// more than one cook at once — each cook is its own collapsible section
/// with its own "تأكيد طلب `<cook>`" button (the backend only ever confirms
/// one cook per call, so there's no single "confirm everything" action).
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
        ConfirmReturnedMealsOrder(getIt()),
        getIt(),
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
              ShoppingCartInitial() ||
              ShoppingCartLoading() =>
                const _CartLoadingSkeleton(),
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

class _CartContent extends StatefulWidget {
  const _CartContent({required this.cart, required this.deliveryFee});

  final CartEntity cart;
  final double deliveryFee;

  @override
  State<_CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<_CartContent> {
  // Every cook section starts collapsed — the customer opens whichever one
  // they want to review/confirm.
  String? _expandedCookId;

  // Each cook section can be delivered to a different location — picked via
  // the "تحديد الموقع" row above that section's confirm button, defaulting
  // to nothing (checkout then falls back to the registration-time address
  // *and* coordinates). Keeps the full detected location, not just the
  // formatted address text — `/order/confirm` requires latitude/longitude
  // on every call, and those have to come from here too, not just the
  // address shown on screen.
  final Map<String, DetectedLocationEntity> _locationByCookId = {};
  final Set<String> _detectingCookIds = {};
  late final DetectCurrentLocation _detectCurrentLocation =
      DetectCurrentLocation(getIt());

  Future<void> _pickLocation(String cookId) async {
    setState(() => _detectingCookIds.add(cookId));
    final result = await _detectCurrentLocation();
    if (!mounted) return;
    setState(() {
      _detectingCookIds.remove(cookId);
      result.fold(
        (location) => _locationByCookId[cookId] = location,
        (exception) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(exception.message))),
      );
    });
  }

  Future<void> _confirmReturnedMeals(BuildContext context) async {
    final cubit = context.read<ShoppingCartCubit>();
    final confirmed = await ConfirmationDialog.show(
      context,
      title: 'تأكيد الطلب',
      message: 'هل تريد تأكيد طلب عناصر "من نصيبك"؟',
      confirmLabel: 'تأكيد',
    );
    if (!confirmed || !context.mounted) return;
    final result = await cubit.confirmReturnedMeals();
    if (!context.mounted) return;
    result.fold(
      (orderId) => context.push('/order-confirmation/$orderId'),
      (exception) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(exception.message))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShoppingCartCubit>();
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currencySuffix = AppLocalizations.of(context)!.currencySuffix;

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: [
        for (final group in widget.cart.cookGroups) ...[
          _CookGroupCard(
            group: group,
            isExpanded: _expandedCookId == group.cookId,
            onToggle: () => setState(() {
              _expandedCookId =
                  _expandedCookId == group.cookId ? null : group.cookId;
            }),
            onQuantityChanged: (itemId, quantity) =>
                cubit.changeQuantity(itemId, quantity),
            onSellingOptionChanged: (itemId, optionId) =>
                cubit.changeSellingOption(itemId, optionId),
            onNoteChanged: (itemId, note) => cubit.changeNote(itemId, note),
            onRemoveItem: (itemId, name) async {
              final confirmed = await ConfirmationDialog.show(
                context,
                title: 'إزالة الصنف',
                message: 'هل تريد إزالة "$name" من السلة؟',
                confirmLabel: 'إزالة',
                isDestructive: true,
              );
              if (confirmed) {
                // ignore: use_build_context_synchronously
                cubit.removeItem(itemId);
              }
            },
            selectedAddress: _locationByCookId[group.cookId]?.formattedAddress,
            isDetectingLocation: _detectingCookIds.contains(group.cookId),
            onPickLocation: () => _pickLocation(group.cookId),
            // Doesn't call the backend directly anymore — takes the
            // customer to a review screen first (line items, expected
            // time, delivery date/time), and only *that* screen's own
            // "إتمام الطلب" button places the real order.
            onConfirmGroup: () => context.push(
              '/checkout-review',
              extra: (
                group: group,
                deliveryFee: widget.deliveryFee,
                deliveryAddress:
                    _locationByCookId[group.cookId]?.formattedAddress,
                latitude: _locationByCookId[group.cookId]?.latitude,
                longitude: _locationByCookId[group.cookId]?.longitude,
              ),
            ),
            currencySuffix: currencySuffix,
          ),
          const SizedBox(height: AppSpace.m),
        ],
        // CU-15: "من نصيبك" returned-meal items are grouped by type,
        // not by chef — no quantity stepper beyond the limited stock
        // claimed, and they aren't part of any cook's confirm call,
        // so they get their own confirm button instead.
        if (widget.cart.returnedMealItems.isNotEmpty) ...[
          Text('من نصيبك', style: textTheme.titleMedium),
          const SizedBox(height: AppSpace.s),
          for (final item in widget.cart.returnedMealItems) ...[
            _SimpleCartRow(
              title: item.mealName,
              subtitle: 'كمية ×${item.quantity}',
              value: item.subtotal,
              currencySuffix: currencySuffix,
              onRemove: () => cubit.removeItem(item.id),
            ),
            const Divider(height: AppSpace.xl),
          ],
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _confirmReturnedMeals(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: scheme.primary,
                side: BorderSide(color: scheme.primary),
                padding:
                    const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              child: const Text('تأكيد طلب من نصيبك'),
            ),
          ),
        ],
      ],
    );
  }
}

/// One collapsible cook section — collapsed shows just the cook's
/// name/avatar; expanded shows every meal/offer line plus this cook's own
/// outlined "تأكيد طلب `<cook>`" button (R-08: sumac/primary is reserved for
/// positive actions; a section confirm stays outlined rather than filled).
class _CookGroupCard extends StatelessWidget {
  const _CookGroupCard({
    required this.group,
    required this.isExpanded,
    required this.onToggle,
    required this.onQuantityChanged,
    required this.onSellingOptionChanged,
    required this.onNoteChanged,
    required this.onRemoveItem,
    required this.selectedAddress,
    required this.isDetectingLocation,
    required this.onPickLocation,
    required this.onConfirmGroup,
    required this.currencySuffix,
  });

  final CartCookGroupEntity group;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String itemId, int quantity) onQuantityChanged;
  final void Function(String itemId, String optionId) onSellingOptionChanged;
  final void Function(String itemId, String note) onNoteChanged;
  final void Function(String itemId, String name) onRemoveItem;
  final String? selectedAddress;
  final bool isDetectingLocation;
  final VoidCallback onPickLocation;
  final String currencySuffix;
  final VoidCallback onConfirmGroup;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onToggle,
            child: Row(
              children: [
                if (group.cookAvatarUrl != null) ...[
                  ClipOval(
                    child: Image.network(
                      group.cookAvatarUrl!,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: AppSpace.s),
                ],
                // Natural-sized text (not `Expanded`) so it hugs the avatar
                // at the start (right, RTL) instead of drifting toward the
                // chevron — the `Spacer` below is what pushes the chevron
                // all the way to the end (left).
                Text(
                  group.cookName,
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: scheme.primary),
              ],
            ),
          ),
          if (isExpanded) ...[
            for (final item in group.mealItems) ...[
              CartItemRow(
                item: item,
                currencySuffix: currencySuffix,
                onQuantityChanged: (quantity) =>
                    onQuantityChanged(item.id, quantity),
                onSellingOptionChanged: (optionId) =>
                    onSellingOptionChanged(item.id, optionId),
                onNoteChanged: (note) => onNoteChanged(item.id, note),
                onRemove: () => onRemoveItem(item.id, item.mealName),
              ),
              const Divider(height: AppSpace.xl),
            ],
            for (final item in group.offerItems) ...[
              _SimpleCartRow(
                title: item.offerName,
                subtitle: 'عرض ×${item.quantity}',
                value: item.subtotal,
                currencySuffix: currencySuffix,
                onRemove: () => onRemoveItem(item.id, item.offerName),
              ),
              const Divider(height: AppSpace.xl),
            ],
            InkWell(
              onTap: isDetectingLocation ? null : onPickLocation,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(vertical: AppSpace.s),
                child: Row(
                  children: [
                    Icon(Icons.chevron_left, color: scheme.onSurfaceVariant),
                    const SizedBox(width: AppSpace.xs),
                    Expanded(
                      child: Text(
                        selectedAddress ?? 'تحديد الموقع',
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                    const SizedBox(width: AppSpace.xs),
                    if (isDetectingLocation)
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: scheme.primary),
                      )
                    else
                      Icon(Icons.location_on_outlined,
                          size: 18, color: scheme.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpace.s),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: group.isEmpty ? null : onConfirmGroup,
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.primary,
                  side: BorderSide(color: scheme.primary),
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: AppSpace.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
                child: Text('لتأكيد طلب ${group.cookName}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SimpleCartRow extends StatelessWidget {
  const _SimpleCartRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.currencySuffix,
    required this.onRemove,
  });

  final String title;
  final String subtitle;
  final double value;
  final String currencySuffix;
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
              Text(subtitle,
                  style: textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} $currencySuffix',
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
