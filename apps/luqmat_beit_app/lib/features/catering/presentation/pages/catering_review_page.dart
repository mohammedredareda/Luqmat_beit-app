import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/entities/catering_request_entity.dart';
import '../../domain/usecases/get_catering_draft.dart';
import '../../domain/usecases/submit_catering_request.dart';
import '../cubit/catering_review_cubit.dart';
import '../cubit/catering_review_state.dart';
import '../widgets/catering_item_card.dart';
import '../widgets/catering_review_pending_dialog.dart';

/// CU-25 (catering / bulk order review). Referenced by the router at
/// `/catering-review` — no bottom nav bar on this screen, per the
/// catering_review_s12 mockup (a review/confirmation flow, not a tab).
class CateringReviewPage extends StatelessWidget {
  const CateringReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CateringReviewCubit(
        GetCateringDraft(getIt()),
        SubmitCateringRequest(getIt()),
      )..loadDraft(),
      child: const _CateringReviewView(),
    );
  }
}

class _CateringReviewView extends StatelessWidget {
  const _CateringReviewView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('لُقمة بيت'),
      ),
      body: SafeArea(
        child: BlocConsumer<CateringReviewCubit, CateringReviewState>(
          listenWhen: (previous, current) => current is CateringReviewSubmitted,
          listener: (context, state) async {
            if (state is CateringReviewSubmitted) {
              await CateringReviewPendingDialog.show(context);
              if (context.mounted) context.pop();
            }
          },
          builder: (context, state) {
            return switch (state) {
              CateringReviewInitial() || CateringReviewLoading() =>
                const _CateringReviewSkeleton(),
              CateringReviewFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل ملخص الطلب',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<CateringReviewCubit>().loadDraft(),
                ),
              CateringReviewLoaded(:final request) => _CateringReviewContent(
                  request: request,
                  isSubmitting: false,
                ),
              CateringReviewSubmitting(:final request) => _CateringReviewContent(
                  request: request,
                  isSubmitting: true,
                ),
              CateringReviewSubmitted(:final request) => _CateringReviewContent(
                  request: request,
                  isSubmitting: false,
                ),
            };
          },
        ),
      ),
    );
  }
}

class _CateringReviewContent extends StatelessWidget {
  const _CateringReviewContent({required this.request, required this.isSubmitting});

  final CateringRequestEntity request;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            children: [
              Text('ملخص الطلب', style: textTheme.headlineSmall),
              const SizedBox(height: AppSpace.xl),
              for (final item in request.items) ...[
                CateringItemCard(item: item),
                const SizedBox(height: AppSpace.m),
              ],
              const SizedBox(height: AppSpace.m),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                decoration: BoxDecoration(
                  border: BorderDirectional(top: BorderSide(color: scheme.outline)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('المجموع التقريبي', style: textTheme.titleMedium),
                    Text(
                      '${request.totalEstimate.toStringAsFixed(0)} د.أ',
                      style: textTheme.headlineSmall
                          ?.copyWith(color: scheme.primary, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.xl),
              _DetailRow(
                icon: Icons.groups,
                label: 'عدد الضيوف',
                value: '${request.guestCount}',
              ),
              const SizedBox(height: AppSpace.m),
              _DetailRow(
                icon: Icons.event,
                label: 'تاريخ المناسبة',
                value: _formatDate(request.eventDate),
              ),
              const SizedBox(height: AppSpace.m),
              _DetailRow(
                icon: Icons.location_on,
                label: 'عنوان التوصيل',
                value: request.deliveryAddress,
              ),
              if (request.specialInstructions != null &&
                  request.specialInstructions!.isNotEmpty) ...[
                const SizedBox(height: AppSpace.m),
                _DetailRow(
                  icon: Icons.notes,
                  label: 'ملاحظات خاصة',
                  value: request.specialInstructions!,
                ),
              ],
            ],
          ),
        ),
        // R-01: exactly one full-width primary button per screen.
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpace.l),
          decoration: BoxDecoration(
            color: scheme.surface,
            border: BorderDirectional(top: BorderSide(color: scheme.outline.withValues(alpha: 0.3))),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () => context.read<CateringReviewCubit>().submit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text('إرسال الطلب للمراجعة'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: scheme.onSurfaceVariant),
        const SizedBox(width: AppSpace.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
              const SizedBox(height: 2),
              Text(value, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _CateringReviewSkeleton extends StatelessWidget {
  const _CateringReviewSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 28, width: 160),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 96, borderRadius: 16),
        SizedBox(height: AppSpace.m),
        LoadingSkeleton(height: 96, borderRadius: 16),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 44),
      ],
    );
  }
}
