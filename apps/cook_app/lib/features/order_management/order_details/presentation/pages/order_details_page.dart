import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/order_line_items.dart';
import '../../../shared/presentation/widgets/pending_countdown.dart';
import '../bloc/order_action_status.dart';
import '../bloc/order_details_bloc.dart';
import '../bloc/order_details_event.dart';
import '../bloc/order_details_state.dart';
import '../widgets/order_details_skeleton.dart';
import '../widgets/order_network_error_view.dart';
import '../widgets/reject_order_dialog.dart';

/// CK-17 (details) + CK-18 (accept/reject) + CK-19 (complete). One route,
/// one page — the body branches on the order's status (`_PendingDecisionView`
/// / `_PreparingTrackingView` / `_ReadOnlySummaryView`) rather than being
/// three separately-routed screens, since the router can't know the status
/// before the fetch resolves.
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<OrderDetailsBloc>()..add(OrderDetailsEvent.loadRequested(orderId)),
      child: _OrderDetailsView(orderId: orderId),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  const _OrderDetailsView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<OrderDetailsBloc, OrderDetailsState>(
      listenWhen: (previous, current) {
        if (current is! OrderDetailsLoaded) return false;
        if (previous is! OrderDetailsLoaded) return true;
        return previous.actionStatus != current.actionStatus;
      },
      listener: (context, state) => _handleActionStatus(context, l10n, state as OrderDetailsLoaded),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.orderDetailsTitle)),
        body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
          builder: (context, state) => state.when(
            initial: () => const OrderDetailsSkeleton(),
            loading: () => const OrderDetailsSkeleton(),
            loadError: (exception) => OrderNetworkErrorView(
              message: exception.message,
              onRetry: () =>
                  context.read<OrderDetailsBloc>().add(OrderDetailsEvent.loadRequested(orderId)),
            ),
            loaded: (order, actionStatus) => _LoadedBody(
              order: order,
              isSubmitting: actionStatus is OrderActionStatusSubmitting,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleActionStatus(
    BuildContext context,
    AppLocalizations l10n,
    OrderDetailsLoaded state,
  ) {
    return state.actionStatus.when(
      idle: () async {},
      submitting: () async {},
      acceptSucceeded: () => _popAfterSuccess(context, l10n.orderAcceptedSuccessMessage, l10n),
      rejectSucceeded: () => _popAfterSuccess(context, l10n.orderRejectedSuccessMessage, l10n),
      completeSucceeded: () => _popAfterSuccess(context, l10n.orderCompletedSuccessMessage, l10n),
      rejectionReasonRequired: () async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.rejectionReasonRequiredError)));
      },
      expired: () async {
        await _showOkDialog(context, message: l10n.orderExpiredOnAcceptMessage);
      },
      failure: (exception) async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message)));
      },
    );
  }

  Future<void> _popAfterSuccess(
    BuildContext context,
    String message,
    AppLocalizations l10n,
  ) async {
    await _showOkDialog(context, message: message);
    if (context.mounted) Navigator.of(context).maybePop();
  }

  Future<void> _showOkDialog(BuildContext context, {required String message}) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.okLabel),
          ),
        ],
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.order, required this.isSubmitting});

  final OrderEntity order;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: [
        _OrderHeaderCard(order: order),
        const SizedBox(height: AppSpace.m),
        _ItemsSection(order: order),
        const SizedBox(height: AppSpace.m),
        _SummaryCard(order: order),
        const SizedBox(height: AppSpace.xl),
        switch (order.status) {
          OrderStatus.pending => _PendingDecisionActions(order: order, isSubmitting: isSubmitting),
          OrderStatus.preparing =>
            _PreparingTrackingActions(order: order, isSubmitting: isSubmitting),
          OrderStatus.done ||
          OrderStatus.delivering ||
          OrderStatus.delivered ||
          OrderStatus.rejected ||
          OrderStatus.cancelled ||
          OrderStatus.returned =>
            _ReadOnlyBanner(order: order),
        },
      ],
    );
  }
}

class _OrderHeaderCard extends StatelessWidget {
  const _OrderHeaderCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final createdAt = order.createdAt;

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.orderNumberLabel(order.id), style: textTheme.titleMedium),
                const SizedBox(height: AppSpace.xs),
                Text(
                  '${createdAt.day.toString().padLeft(2, '0')}/'
                  '${createdAt.month.toString().padLeft(2, '0')}/'
                  '${createdAt.year} '
                  '${createdAt.hour.toString().padLeft(2, '0')}:'
                  '${createdAt.minute.toString().padLeft(2, '0')}',
                  style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
                if (order.status == OrderStatus.pending && order.pendingExpiresAt != null) ...[
                  const SizedBox(height: AppSpace.xs),
                  PendingCountdown(expiresAt: order.pendingExpiresAt!),
                ],
              ],
            ),
          ),
          OrderStatusBadge(status: order.status),
        ],
      ),
    );
  }
}

class _ItemsSection extends StatelessWidget {
  const _ItemsSection({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final items = flattenOrderLineItems(order);

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.orderItemsSectionTitle, style: textTheme.titleSmall),
          const SizedBox(height: AppSpace.m),
          for (final item in items) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.image),
                  child: Image.network(
                    item.imageUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 72,
                      height: 72,
                      color: scheme.surfaceContainerHighest,
                      child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpace.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: AppSpace.s),
                          Text(
                            '${item.priceAtPurchase.toStringAsFixed(0)} ${l10n.currencySuffix}',
                            style: AppText.price(context),
                          ),
                        ],
                      ),
                      if (item.selectedOptionLabel != null) ...[
                        const SizedBox(height: AppSpace.xs),
                        Text(
                          l10n.selectedOptionLabel(item.selectedOptionLabel!),
                          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                      const SizedBox(height: AppSpace.xs),
                      Row(
                        children: [
                          Text(l10n.quantityLabel(item.quantity), style: textTheme.bodySmall),
                          if (item.isReturned) ...[
                            const SizedBox(width: AppSpace.s),
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: AppSpace.s,
                                vertical: AppSpace.xs,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(AppRadius.pill),
                              ),
                              child: Text(
                                l10n.returnedItemBadge,
                                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (item.note != null && item.note!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpace.xs),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpace.s),
                            decoration: BoxDecoration(
                              color: scheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(AppRadius.badge),
                            ),
                            child: Text(
                              l10n.itemNoteLabel(item.note!),
                              style: textTheme.bodySmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (item != items.last) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpace.s),
                child: Divider(height: 1),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget row(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
      final rowColor = isDiscount ? AppColors.zaatar : null;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: (isTotal ? textTheme.titleMedium : textTheme.bodyMedium)
                  ?.copyWith(color: rowColor),
            ),
            Text(
              '${amount.toStringAsFixed(0)} ${l10n.currencySuffix}',
              style: isTotal
                  ? AppText.price(context)
                  : textTheme.bodyMedium?.copyWith(color: rowColor),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.orderSummaryTitle, style: textTheme.titleSmall),
          const SizedBox(height: AppSpace.s),
          row(l10n.subtotalLabel, order.itemsTotal),
          if (order.discountAmount > 0)
            row(l10n.discountLabel, -order.discountAmount, isDiscount: true),
          const Divider(height: AppSpace.l),
          row(l10n.totalLabel, order.grandTotal, isTotal: true),
        ],
      ),
    );
  }
}

class _PendingDecisionActions extends StatelessWidget {
  const _PendingDecisionActions({required this.order, required this.isSubmitting});

  final OrderEntity order;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: isSubmitting
                ? null
                : () => context.read<OrderDetailsBloc>().add(
                      const OrderDetailsEvent.acceptPressed(),
                    ),
            child: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.acceptOrderCta),
          ),
        ),
        const SizedBox(width: AppSpace.s),
        Expanded(
          child: OutlinedButton(
            onPressed: isSubmitting
                ? null
                : () async {
                    final reason =
                        await RejectOrderDialog.show(context, orderId: order.id);
                    if (reason != null && context.mounted) {
                      context
                          .read<OrderDetailsBloc>()
                          .add(OrderDetailsEvent.rejectPressed(reason));
                    }
                  },
            style: OutlinedButton.styleFrom(
              foregroundColor: scheme.error,
              side: BorderSide(color: scheme.error, width: 1.5),
            ),
            child: Text(l10n.rejectOrderCta),
          ),
        ),
      ],
    );
  }
}

class _PreparingTrackingActions extends StatelessWidget {
  const _PreparingTrackingActions({required this.order, required this.isSubmitting});

  final OrderEntity order;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpace.m),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: scheme.onSurfaceVariant),
              const SizedBox(width: AppSpace.s),
              Expanded(
                child: Text(l10n.preparingDoneBannerBody,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.m),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isSubmitting
                ? null
                : () => context
                    .read<OrderDetailsBloc>()
                    .add(const OrderDetailsEvent.completePressed()),
            icon: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_circle_outline),
            label: Text(l10n.markPreparedCta),
          ),
        ),
      ],
    );
  }
}

class _ReadOnlyBanner extends StatelessWidget {
  const _ReadOnlyBanner({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    if (order.status == OrderStatus.rejected ||
        order.status == OrderStatus.cancelled ||
        order.status == OrderStatus.returned) {
      // R-10: a rejected/cancelled status must never appear without a
      // visible reason. Cook-rejected orders always carry a rejectionReason
      // (CK-18); system-cancelled orders (CK-25) never do, so the banner
      // text (and its label) differ by which of the two actually happened.
      final reason = order.rejectionReason;
      final label = reason != null ? l10n.rejectionReasonLabel : null;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: scheme.onErrorContainer)),
              const SizedBox(height: AppSpace.xs),
            ],
            Text(
              reason ?? l10n.orderCancelledAutomaticallyBanner,
              style: TextStyle(color: scheme.onErrorContainer),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
