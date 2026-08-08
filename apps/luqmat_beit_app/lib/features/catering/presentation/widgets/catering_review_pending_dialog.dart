import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The "الطلب قيد المراجعة" confirmation modal from catering_review_s12 —
/// shown after submitting a bulk order, since large quantities require
/// human verification before support confirms the request.
class CateringReviewPendingDialog extends StatelessWidget {
  const CateringReviewPendingDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CateringReviewPendingDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sheet),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_top, color: AppColors.warning, size: 28),
            const SizedBox(height: AppSpace.m),
            Text(
              'الطلب قيد المراجعة',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: scheme.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpace.m),
            Text(
              'هذا الطلب يتطلب تحققاً بشرياً نظراً لكميته الكبيرة، '
              'سيتواصل معك فريق الدعم قريباً للتأكيد',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpace.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('حسناً'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
