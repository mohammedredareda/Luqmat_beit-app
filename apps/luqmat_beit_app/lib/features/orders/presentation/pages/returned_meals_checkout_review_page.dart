import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/confirm_returned_meals_order.dart';

/// Shown when the customer taps "تأكيد طلب من نصيبك" in the cart — mirrors
/// [CheckoutReviewPage]'s per-cook flow (review first, only "إتمام الطلب"
/// here actually places the order) so "من نصيبك" checkout behaves exactly
/// like a regular order instead of confirming straight from the cart with
/// whatever location happens to be cached from registration.
class ReturnedMealsCheckoutReviewPage extends StatefulWidget {
  const ReturnedMealsCheckoutReviewPage({
    super.key,
    required this.returnedMealItems,
    this.deliveryAddress,
    this.latitude,
    this.longitude,
  });

  final List<CartReturnedMealItemEntity> returnedMealItems;
  final String? deliveryAddress;
  final double? latitude;
  final double? longitude;

  @override
  State<ReturnedMealsCheckoutReviewPage> createState() =>
      _ReturnedMealsCheckoutReviewPageState();
}

class _ReturnedMealsCheckoutReviewPageState
    extends State<ReturnedMealsCheckoutReviewPage> {
  late final ConfirmReturnedMealsOrder _confirmReturnedMealsOrder =
      ConfirmReturnedMealsOrder(getIt());
  bool _submitting = false;

  double get _itemsTotal =>
      widget.returnedMealItems.fold(0.0, (sum, i) => sum + i.subtotal);

  // Same rule as the per-cook review screen: no picked location, no
  // "إتمام الطلب" — never silently fall back to a stale registration-time
  // location the customer never chose for *this* order.
  bool get _hasLocation => widget.latitude != null && widget.longitude != null;

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final result = await _confirmReturnedMealsOrder(
      returnedMealItems: widget.returnedMealItems,
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
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sheet)),
        icon: Icon(Icons.storefront_outlined, size: 48, color: scheme.error),
        title: const Text('تعذر إتمام الطلب', textAlign: TextAlign.center),
        content: Text(exception.message, textAlign: TextAlign.center),
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
    final currencySuffix = AppLocalizations.of(context)!.currencySuffix;

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
                  for (final item in widget.returnedMealItems)
                    _LineItemRow(
                      label: '${item.mealName} ×${item.quantity}',
                      value: item.subtotal,
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
                        '${_itemsTotal.toStringAsFixed(0)} $currencySuffix',
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
                  Text(
                    widget.deliveryAddress ?? 'لم يتم تحديد الموقع بعد',
                    style: textTheme.bodyMedium,
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
