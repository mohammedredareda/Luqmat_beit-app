import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../../domain/usecases/confirm_delivery_receipt.dart';
import '../../domain/usecases/get_delivered_order.dart';
import '../../domain/usecases/report_delivery_issue.dart';
import '../bloc/delivery_acceptance_bloc.dart';
import '../bloc/delivery_acceptance_event.dart';
import '../bloc/delivery_acceptance_state.dart';
import '../widgets/delivery_acceptance_dialog.dart';
import '../widgets/delivery_driver_card.dart';
import '../widgets/delivery_map_placeholder.dart';
import '../widgets/delivery_order_summary_card.dart';

/// CU-22 — "Delivery Receipt": the customer confirms or disputes receiving
/// a just-delivered order. No bottom nav bar on this screen (mockup:
/// `delivery_acceptance_u11/code.html`).
class DeliveryAcceptancePage extends StatelessWidget {
  const DeliveryAcceptancePage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeliveryAcceptanceBloc(
        GetDeliveredOrder(getIt<DeliveryRepository>()),
        ConfirmDeliveryReceipt(getIt<DeliveryRepository>()),
        ReportDeliveryIssue(getIt<DeliveryRepository>()),
      )..add(DeliveryAcceptanceEvent.started(orderId)),
      child: _DeliveryAcceptanceView(orderId: orderId),
    );
  }
}

class _DeliveryAcceptanceView extends StatelessWidget {
  const _DeliveryAcceptanceView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<DeliveryAcceptanceBloc, DeliveryAcceptanceState>(
          builder: (context, state) {
            return switch (state) {
              DeliveryAcceptanceInitial() ||
              DeliveryAcceptanceLoading() =>
                const _DeliveryLoadingSkeleton(),
              DeliveryAcceptanceFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل تفاصيل الطلب',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context
                      .read<DeliveryAcceptanceBloc>()
                      .add(DeliveryAcceptanceEvent.started(orderId)),
                ),
              DeliveryAcceptanceLoaded(
                :final order,
                :final isReportingIssue,
                :final reason,
                :final reasonError,
                :final isProcessing,
              ) =>
                _DeliveryAcceptanceContent(
                  order: order,
                  isReportingIssue: isReportingIssue,
                  reason: reason,
                  reasonError: reasonError,
                  isProcessing: isProcessing,
                ),
              DeliveryAcceptanceConfirmed() => const _OutcomeView(
                  icon: Icons.check_circle,
                  title: 'تم استلام الطلب بنجاح!',
                  message: 'بالعافية.',
                ),
              DeliveryAcceptanceReported() => const _OutcomeView(
                  icon: Icons.support_agent,
                  title: 'تم إرسال سبب الرفض',
                  message: 'سيقوم فريق الدعم بالتواصل معك فوراً.',
                ),
            };
          },
        ),
      ),
    );
  }
}

class _DeliveryAcceptanceContent extends StatelessWidget {
  const _DeliveryAcceptanceContent({
    required this.order,
    required this.isReportingIssue,
    required this.reason,
    required this.reasonError,
    required this.isProcessing,
  });

  final OrderEntity order;
  final bool isReportingIssue;
  final String reason;
  final String? reasonError;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsetsDirectional.all(AppSpace.l),
          children: [
            const DeliveryDriverCard(
              name: 'أحمد محمود',
              avatarUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCe_c1wBBE-E8Ya_Xagf0nFCJZA84drekJqSkm2rY-RXEwywecKg4Nmv72Iw-sGGL0t1bZfNGkc1SYXnIPL5G03RLKrHpheEkC7eU9GyB_vju7J4SAjLTEFhsZah2hg16UJPyrAIaIsEe0poSWgmRSuK2Ed2gDP0E6Mjvu3z_alR4VLfo2P2D0hHl3gKLPRi-MJ4qg5z7ZGzdwghg-2GGVELuVqqhYNlJWrbta7EN9saCgvm8OLJ9HW',
              rating: 4.9,
              ratingCount: 240,
              statusLabel: 'في الطريق',
            ),
            const SizedBox(height: AppSpace.xl),
            DeliveryOrderSummaryCard(order: order),
            const SizedBox(height: AppSpace.xl),
            const DeliveryMapPlaceholder(
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA6Kpn3cBfdwxxw1oDuLTI2D6fUqi_wSa4hbvy_S_Kg-hceNSi9drt2TPbudxt0L6DX8YwiD7VwYMz9UPsJU8SRXFytvxJ7Jr5zskTbCo22k71avbc5UxrSpLe3v_laTRnZR27-V3ZLTr-QCTWhH8fMrM12Q8qtXeJSw5DDli2-gqZzBly4AQFE4xOIyr0kZuMk7GvGPL-lzM3lr6c-hH5M66LtRs07ZuzBtATB8NB2ArxaF0zyAR-V',
            ),
            const SizedBox(height: 220),
          ],
        ),
        // Dimmed backdrop under the acceptance dialog, matching the
        // mockup's `bg-warm-charcoal/60 backdrop-blur-sm`.
        Positioned.fill(
          child: IgnorePointer(
            child: Container(color: AppColors.inkLight.withValues(alpha: 0.4)),
          ),
        ),
        PositionedDirectional(
          start: AppSpace.l,
          end: AppSpace.l,
          bottom: AppSpace.xl,
          child: DeliveryAcceptanceDialog(
            isReportingIssue: isReportingIssue,
            reason: reason,
            reasonError: reasonError,
            isProcessing: isProcessing,
            onAccept: () => context
                .read<DeliveryAcceptanceBloc>()
                .add(const DeliveryAcceptanceEvent.confirmReceiptRequested()),
            onToggleReportIssue: () => context
                .read<DeliveryAcceptanceBloc>()
                .add(const DeliveryAcceptanceEvent.reportIssueToggled()),
            onReasonChanged: (value) => context
                .read<DeliveryAcceptanceBloc>()
                .add(DeliveryAcceptanceEvent.reasonChanged(value)),
            onSubmitReason: () => context
                .read<DeliveryAcceptanceBloc>()
                .add(const DeliveryAcceptanceEvent.reportIssueSubmitted()),
          ),
        ),
      ],
    );
  }
}

class _OutcomeView extends StatelessWidget {
  const _OutcomeView({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: icon,
      title: title,
      message: message,
      actionLabel: 'العودة إلى طلباتي',
      onAction: () => context.go('/orders'),
    );
  }
}

class _DeliveryLoadingSkeleton extends StatelessWidget {
  const _DeliveryLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 80, borderRadius: 16),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 220, borderRadius: 16),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 192, borderRadius: 16),
      ],
    );
  }
}
