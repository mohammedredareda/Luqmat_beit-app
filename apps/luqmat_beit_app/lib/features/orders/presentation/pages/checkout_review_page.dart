import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/confirm_order.dart';
import '../../domain/usecases/get_delivery_price.dart';

/// Shown when the customer taps "تأكيد طلب `<cook>`" in the cart — a review
/// of that one cook's order (items, total, expected time) *before* the
/// real `POST /order/confirm` call fires.
/// Only pressing "إتمام الطلب" here actually places the order — matching
/// the cart's own confirm button, which used to call the backend directly
/// and, on a business rejection (e.g. "cook is currently closed"), had
/// nothing to show but the raw error. This screen absorbs that instead.
class CheckoutReviewPage extends StatefulWidget {
  const CheckoutReviewPage({
    super.key,
    required this.group,
    required this.deliveryFee,
    this.deliveryAddress,
    this.latitude,
    this.longitude,
  });

  final CartCookGroupEntity group;
  final double deliveryFee;
  final String? deliveryAddress;
  final double? latitude;
  final double? longitude;

  @override
  State<CheckoutReviewPage> createState() => _CheckoutReviewPageState();
}

class _CheckoutReviewPageState extends State<CheckoutReviewPage> {
  late final ConfirmOrder _confirmOrder = ConfirmOrder(getIt());
  late final GetDeliveryPrice _getDeliveryPrice = GetDeliveryPrice(getIt());
  bool _submitting = false;

  // `/order/confirm` always recomputes the real charge server-side from
  // the same cook/location inputs — this is purely a "show the real price
  // before committing" preview, so a failed fetch just falls back to
  // [widget.deliveryFee] (the cart's flat placeholder) rather than
  // blocking checkout over a display-only number.
  bool _loadingDeliveryPrice = false;
  double? _realDeliveryFee;
  int? _expectedTimeMinutes;

  double get _deliveryFee => _realDeliveryFee ?? widget.deliveryFee;

  @override
  void initState() {
    super.initState();
    if (_hasLocation) _loadDeliveryPrice();
  }

  Future<void> _loadDeliveryPrice() async {
    setState(() => _loadingDeliveryPrice = true);
    final result = await _getDeliveryPrice(
      cookId: widget.group.cookId,
      latitude: widget.latitude!,
      longitude: widget.longitude!,
    );
    if (!mounted) return;
    setState(() {
      _loadingDeliveryPrice = false;
      result.fold(
        (quote) {
          _realDeliveryFee = quote.price;
          _expectedTimeMinutes = quote.expectedTimeMinutes;
        },
        (_) {}, // Keep the flat placeholder — see the field doc above.
      );
    });
  }

  double get _itemsTotal =>
      widget.group.mealItems.fold(0.0, (sum, i) => sum + i.subtotal) +
      widget.group.offerItems.fold(0.0, (sum, i) => sum + i.subtotal);

  // `/order/confirm` requires real coordinates on every call — without a
  // location picked (via the cart's "تحديد الموقع"), there's nothing valid
  // to send, so "إتمام الطلب" stays disabled rather than silently falling
  // back to a stale/registration-time location the customer never chose
  // for *this* order.
  bool get _hasLocation => widget.latitude != null && widget.longitude != null;

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final result = await _confirmOrder(
      cookId: widget.group.cookId,
      deliveryAddress: widget.deliveryAddress ?? '',
      deliveryFee: _deliveryFee,
      mealItems: widget.group.mealItems,
      offerItems: widget.group.offerItems,
      latitude: widget.latitude,
      longitude: widget.longitude,
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    result.fold(
      (orderId) => context.pushReplacement('/receipt/$orderId'),
      _showFriendlyError,
    );
  }

  void _showFriendlyError(AppException exception) {
    final scheme = Theme.of(context).colorScheme;
    final message = exception.message;
    // Only for picking a nicer *title* — the body always shows the real
    // backend message below. This used to also swap in a canned "cook is
    // closed" body whenever the message loosely matched, which was wrong
    // often enough to be misleading: plenty of unrelated errors (stock,
    // price-changed, validation) contain the same words ("متاحة" etc.)
    // without the cook actually being closed.
    final isCookClosed = message.contains('closed') || message.contains('مغلق');

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sheet)),
        icon: Icon(Icons.storefront_outlined, size: 48, color: scheme.error),
        title: Text(
          isCookClosed ? 'الطباخ غير متاح حالياً' : 'تعذر إتمام الطلب',
          textAlign: TextAlign.center,
        ),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('حسناً'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsetsDirectional.all(AppSpace.l),
          children: [
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(bottom: AppSpace.s),
                    child: Text('الفاتورة', style: textTheme.titleLarge),
                  ),
                  Divider(color: scheme.outlineVariant),
                  for (final item in widget.group.mealItems)
                    _LineItemRow(
                      label: '${item.mealName} ×${item.quantity}',
                      value: item.subtotal,
                    ),
                  for (final item in widget.group.offerItems)
                    _LineItemRow(
                      label: '${item.offerName} ×${item.quantity}',
                      value: item.subtotal,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('أجرة التوصيل', style: textTheme.bodyLarge),
                      _loadingDeliveryPrice
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_deliveryFee.toStringAsFixed(0),
                              style: textTheme.bodyLarge),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المجموع الكلي',
                        style: textTheme.titleMedium
                            ?.copyWith(color: scheme.primary),
                      ),
                      Text(
                        '${(_itemsTotal + _deliveryFee).toStringAsFixed(0)} ${AppLocalizations.of(context)!.currencySuffix}',
                        style: textTheme.titleMedium
                            ?.copyWith(color: scheme.primary),
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
                      _expectedTimeMinutes != null
                          ? '~ $_expectedTimeMinutes دقيقة'
                          : '60 — 75 دقيقة',
                      style: TextStyle(
                        color: scheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.l),
        decoration: BoxDecoration(
          color: scheme.surface,
          border:
              BorderDirectional(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_hasLocation) ...[
                Row(
                  children: [
                    Icon(Icons.location_off_outlined,
                        size: 16, color: scheme.error),
                    const SizedBox(width: AppSpace.xs),
                    Expanded(
                      child: Text(
                        'حدّد موقع التوصيل من السلة أولاً لتتمكن من إتمام الطلب.',
                        style:
                            textTheme.bodySmall?.copyWith(color: scheme.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.s),
              ],
              ElevatedButton.icon(
                onPressed: (_submitting || !_hasLocation) ? null : _submit,
                icon: _submitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check),
                label: const Text('إتمام الطلب'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineItemRow extends StatelessWidget {
  const _LineItemRow({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: textTheme.bodyLarge)),
          Text(value.toStringAsFixed(0), style: textTheme.bodyLarge),
        ],
      ),
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
