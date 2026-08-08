import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The floating "هل تستلم الطلب؟" card — R-01: only one full-width PRIMARY
/// button per screen, so "قبول واستلام" (accept) is the primary action and
/// "رفض الطلب" (reject) is an error-colored OUTLINED button (R-08:
/// destructive/dispute actions are never primary-colored).
class DeliveryAcceptanceDialog extends StatelessWidget {
  const DeliveryAcceptanceDialog({
    super.key,
    required this.isReportingIssue,
    required this.reason,
    required this.reasonError,
    required this.isProcessing,
    required this.onAccept,
    required this.onToggleReportIssue,
    required this.onReasonChanged,
    required this.onSubmitReason,
  });

  final bool isReportingIssue;
  final String reason;
  final String? reasonError;
  final bool isProcessing;
  final VoidCallback onAccept;
  final VoidCallback onToggleReportIssue;
  final ValueChanged<String> onReasonChanged;
  final VoidCallback onSubmitReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.xl),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.sheet),
        boxShadow: [
          BoxShadow(
            color: AppColors.inkLight.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.inventory_2, color: scheme.primary, size: 32),
          ),
          const SizedBox(height: AppSpace.l),
          Text(
            'هل تستلم الطلب؟',
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpace.s),
          Text(
            'عامل التوصيل بانتظار تأكيدك',
            style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpace.xl),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isProcessing ? null : onAccept,
                  icon: isProcessing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_circle),
                  label: const Text('قبول واستلام'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.l),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isProcessing ? null : onToggleReportIssue,
                  icon: const Icon(Icons.cancel),
                  label: const Text('رفض الطلب'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: scheme.error,
                    side: BorderSide(color: scheme.error),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                  ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isReportingIssue
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(top: AppSpace.l),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(AppSpace.l),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(
                          color: scheme.outlineVariant,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('سبب الرفض', style: textTheme.labelLarge),
                          const SizedBox(height: AppSpace.s),
                          TextField(
                            maxLines: 4,
                            maxLength: NoteLengthValidator.rejectionReasonMax,
                            onChanged: onReasonChanged,
                            decoration: InputDecoration(
                              hintText: 'اكتب سبب الرفض...',
                              errorText: reasonError,
                              filled: true,
                              fillColor: scheme.surface,
                            ),
                          ),
                          const SizedBox(height: AppSpace.s),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isProcessing ? null : onSubmitReason,
                              child: isProcessing
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text('إرسال السبب'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
