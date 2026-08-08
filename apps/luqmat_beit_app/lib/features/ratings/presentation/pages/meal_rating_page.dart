import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_order_to_rate.dart';
import '../../domain/usecases/submit_meal_rating.dart';
import '../cubit/meal_rating_cubit.dart';
import '../cubit/meal_rating_state.dart';
import '../widgets/star_rating_selector.dart';

/// CU-23 — post-delivery star rating + optional written review + a
/// "report an issue" escape hatch. Matches the `meal_rating_s9_replica`
/// mockup: a centered dialog-style card, no bottom nav bar. Reached via
/// `/meal-rating/:orderId`.
class MealRatingPage extends StatelessWidget {
  const MealRatingPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MealRatingCubit(
        GetOrderToRate(getIt()),
        SubmitMealRating(getIt()),
      )..loadOrder(orderId),
      child: _MealRatingView(orderId: orderId),
    );
  }
}

class _MealRatingView extends StatelessWidget {
  const _MealRatingView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: BlocConsumer<MealRatingCubit, MealRatingState>(
          listenWhen: (previous, current) =>
              current is MealRatingSubmitted ||
              (current is MealRatingLoaded && current.submitError != null),
          listener: (context, state) {
            switch (state) {
              case MealRatingSubmitted():
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text('شكراً لتقييمك!'),
                      backgroundColor: scheme.primary,
                    ),
                  );
                if (context.canPop()) {
                  context.pop();
                }
              case MealRatingLoaded(:final submitError?):
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(submitError.message),
                      backgroundColor: scheme.error,
                    ),
                  );
              default:
                break;
            }
          },
          builder: (context, state) {
            return switch (state) {
              MealRatingInitial() || MealRatingLoading() => const _RatingLoadingSkeleton(),
              MealRatingFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل تفاصيل الطلب',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () =>
                      context.read<MealRatingCubit>().loadOrder(orderId),
                ),
              MealRatingLoaded() => _RatingCard(state: state),
              MealRatingSubmitted() => const _RatingCard.submitted(),
            };
          },
        ),
      ),
    );
  }
}

class _RatingCard extends StatelessWidget {
  const _RatingCard({required MealRatingLoaded this.state}) : isSubmitted = false;

  const _RatingCard.submitted()
      : state = null,
        isSubmitted = true;

  final MealRatingLoaded? state;
  final bool isSubmitted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final mealItems = state?.order.mealItems ?? const <OrderMealItemEntity>[];
    final mealName = mealItems.isEmpty ? null : mealItems.first.mealName;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(AppSpace.l),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsetsDirectional.all(AppSpace.xl),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sheet),
            boxShadow: [
              BoxShadow(
                color: scheme.onSurface.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'صحتين وعافية! 🍽',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpace.s),
              Text(
                mealName == null ? 'شو رأيك بالوجبة؟' : 'شو رأيك بـ$mealName؟',
                style: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpace.xl),
              StarRatingSelector(
                value: state?.stars ?? 0,
                onChanged: (value) => context.read<MealRatingCubit>().selectStars(value),
              ),
              const SizedBox(height: AppSpace.l),
              // Optional written review — not present in the literal
              // mockup (stars + two buttons only), added per brief so
              // `submitRating(review: ...)` has a UI path to populate it.
              TextField(
                enabled: !isSubmitted && state?.isSubmitting != true,
                maxLines: 3,
                maxLength: NoteLengthValidator.orderNoteMax,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: 'اكتب مراجعتك (اختياري)',
                ),
                onChanged: (value) =>
                    context.read<MealRatingCubit>().updateReview(value),
              ),
              const SizedBox(height: AppSpace.s),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitted || state == null
                      ? null
                      : state!.stars < 1 || state!.isSubmitting
                          ? null
                          : () => context.read<MealRatingCubit>().submit(),
                  child: state?.isSubmitting == true
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('تقييم'),
                ),
              ),
              const SizedBox(height: AppSpace.m),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isSubmitted ? null : () => _showReportDialog(context),
                  child: const Text('إبلاغ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    final controller = TextEditingController();
    final scheme = Theme.of(context).colorScheme;
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('الإبلاغ عن مشكلة'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(hintText: 'صف المشكلة التي واجهتها'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text('تم استلام بلاغك، شكراً لك'),
                      backgroundColor: scheme.error,
                    ),
                  );
              },
              child: Text('إرسال', style: TextStyle(color: scheme.error)),
            ),
          ],
        );
      },
    );
  }
}

class _RatingLoadingSkeleton extends StatelessWidget {
  const _RatingLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpace.xl),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsetsDirectional.all(AppSpace.xl),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingSkeleton(height: 28, width: 200, borderRadius: 8),
              SizedBox(height: AppSpace.l),
              LoadingSkeleton(height: 40, width: 240),
              SizedBox(height: AppSpace.xl),
              LoadingSkeleton(height: 48, borderRadius: 24),
              SizedBox(height: AppSpace.m),
              LoadingSkeleton(height: 48, borderRadius: 24),
            ],
          ),
        ),
      ),
    );
  }
}
