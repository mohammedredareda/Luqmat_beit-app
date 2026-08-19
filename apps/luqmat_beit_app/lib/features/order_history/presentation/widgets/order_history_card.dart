import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../cubit/order_history_cubit.dart';

/// One past-order row: meal thumbnail, date, status badge and a "reorder"
/// button that calls `POST /user/customer/order/history/re-add` (per the
/// order_history mockup) — matches design_rules.html card styling (4:3
/// image, R-25) reused at 96x72.
class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({super.key, required this.order, required this.onTap});

  final OrderEntity order;
  final VoidCallback onTap;

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y/$m/$d';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final firstItemImageUrl = order.mealItems.isNotEmpty
        ? order.mealItems.first.mealImageUrl
        : order.offerItems.isNotEmpty
            ? ''
            : order.returnedMealItems.first.mealImageUrl;
    final status = order.status;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: SizedBox(
                width: 96,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(firstItemImageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.orderNumberLabel(order.id),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpace.s),
                  Wrap(
                    spacing: AppSpace.s,
                    runSpacing: AppSpace.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpace.s,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          _formatDate(order.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      OrderStatusBadge(status: status),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpace.s),
            _ReorderButton(scheme: scheme, orderId: order.id),
          ],
        ),
      ),
    );
  }
}

class _ReorderButton extends StatefulWidget {
  const _ReorderButton({required this.scheme, required this.orderId});

  final ColorScheme scheme;
  final String orderId;

  @override
  State<_ReorderButton> createState() => _ReorderButtonState();
}

class _ReorderButtonState extends State<_ReorderButton> {
  bool _submitting = false;
  bool _added = false;

  Future<void> _reorder() async {
    if (_submitting) return;
    setState(() => _submitting = true);

    final result = await context.read<OrderHistoryCubit>().reorder(widget.orderId);
    if (!mounted) return;
    setState(() => _submitting = false);

    result.fold(
      (_) {
        setState(() => _added = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت الإضافة إلى السلة')),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _added = false);
        });
      },
      (exception) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(exception.message)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _reorder,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.s,
          vertical: AppSpace.s,
        ),
        decoration: BoxDecoration(
          color: _added ? widget.scheme.secondary : widget.scheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.image),
        ),
        child: _submitting
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: widget.scheme.onPrimary,
                ),
              )
            : Icon(
                _added ? Icons.check : Icons.replay,
                color: widget.scheme.onPrimary,
                size: 18,
              ),
      ),
    );
  }
}
