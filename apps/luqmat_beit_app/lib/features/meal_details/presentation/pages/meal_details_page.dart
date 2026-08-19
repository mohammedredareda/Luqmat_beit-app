import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/add_meal_to_cart.dart';
import '../../domain/usecases/add_returned_meal_to_cart.dart';
import '../../domain/usecases/get_meal_details.dart';
import '../../domain/usecases/report_meal.dart';
import '../../domain/usecases/toggle_meal_favorite.dart';
import '../cubit/meal_details_cubit.dart';
import '../cubit/meal_details_state.dart';
import '../widgets/meal_note_field.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/selling_option_selector.dart';

/// CU-09 (view meal details) / CU-10 (add to cart). Referenced by the
/// router at `/meal/:mealId` — no bottom nav bar on this screen. When
/// reached from Home's "Your Own" slider, [returnedMeal] carries the
/// already-fetched salvage listing (no "get returned meal by id" endpoint
/// exists) so this screen can show the salvage price and add it to the
/// cart via the real `POST /user/customer/cart/returned-meals` endpoint
/// instead of the normal meal add-to-cart flow.
class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key, required this.mealId, this.returnedMeal});

  final String mealId;
  final ReturnedMealEntity? returnedMeal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MealDetailsCubit(
        GetMealDetails(getIt()),
        AddMealToCart(getIt()),
        ToggleMealFavorite(getIt()),
        ReportMeal(getIt()),
        AddReturnedMealToCart(getIt()),
      )..loadMeal(mealId, returnedMeal: returnedMeal),
      child: const _MealDetailsView(),
    );
  }
}

class _MealDetailsView extends StatelessWidget {
  const _MealDetailsView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: BlocConsumer<MealDetailsCubit, MealDetailsState>(
          listenWhen: (previous, current) => current is MealDetailsAddedToCart,
          listener: (context, state) {
            if (state is MealDetailsAddedToCart) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text('تمت الإضافة إلى السلة'),
                    backgroundColor: scheme.primary,
                  ),
                );
              context.read<MealDetailsCubit>().acknowledgeAddedToCart();
            }
          },
          builder: (context, state) {
            return switch (state) {
              MealDetailsInitial() || MealDetailsLoading() =>
                const _MealDetailsSkeleton(),
              MealDetailsFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل تفاصيل الوجبة',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<MealDetailsCubit>().retry(),
                ),
              MealDetailsLoaded(
                :final meal,
                :final selectedSellingOptionId,
                :final quantity,
                :final note,
                :final isFavorite,
                :final returnedMeal,
              ) ||
              MealDetailsAddedToCart(
                :final meal,
                :final selectedSellingOptionId,
                :final quantity,
                :final note,
                :final isFavorite,
                :final returnedMeal,
              ) =>
                _MealDetailsContent(
                  meal: meal,
                  selectedSellingOptionId: selectedSellingOptionId,
                  quantity: quantity,
                  note: note,
                  isFavorite: isFavorite,
                  returnedMeal: returnedMeal,
                ),
            };
          },
        ),
      ),
    );
  }
}

class _MealDetailsContent extends StatelessWidget {
  const _MealDetailsContent({
    required this.meal,
    required this.selectedSellingOptionId,
    required this.quantity,
    required this.note,
    required this.isFavorite,
    this.returnedMeal,
  });

  final MealEntity meal;
  final String selectedSellingOptionId;
  final int quantity;
  final String note;
  final bool isFavorite;
  final ReturnedMealEntity? returnedMeal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<MealDetailsCubit>();
    final l10n = AppLocalizations.of(context)!;

    final selectedOption = meal.sellingOptions.firstWhere(
      (o) => o.id == selectedSellingOptionId,
      orElse: () => meal.sellingOptions.isNotEmpty
          ? meal.sellingOptions.first
          : const SellingOptionEntity(id: '', label: '', price: 0),
    );
    final unitPrice = returnedMeal?.salvagePrice ?? selectedOption.price;
    final totalPrice = unitPrice * quantity;

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.s)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.sheet),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Container(
                            color: scheme.surfaceContainerHighest,
                            child: Image.network(
                              meal.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: scheme.surfaceContainerHighest,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        top: AppSpace.l,
                        end: AppSpace.l,
                        child: GestureDetector(
                          onTap: cubit.toggleFavorite,
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(AppSpace.s),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: scheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Title & rating
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpace.l,
                    end: AppSpace.l,
                    top: AppSpace.l,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          meal.name,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpace.s),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpace.m,
                          vertical: AppSpace.xs,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: scheme.outline),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 16, color: Color(0xFFB97A1E)),
                            const SizedBox(width: AppSpace.xs),
                            Text(
                              '${meal.rating.toStringAsFixed(1)} (${meal.ratingCount})',
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Chef card
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.l)),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(AppSpace.m),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.sheet),
                      border: Border.all(color: scheme.outline),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: scheme.primaryFixed, width: 2),
                          ),
                          child: ClipOval(
                            child: Container(
                              color: scheme.surfaceContainerHighest,
                              child: meal.cookAvatarUrl != null
                                  ? Image.network(
                                      meal.cookAvatarUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const SizedBox(),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpace.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meal.cookName, style: textTheme.titleMedium),
                              const SizedBox(height: AppSpace.xs),
                              Text(
                                'شيف محترف',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => context.push('/chef/${meal.cookId}'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: scheme.outline),
                          ),
                          child: const Text('عرض البروفايل'),
                        ),
                      ],
                    ),
                  ),
                ),
                // Description
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.l)),
                  child: Text(
                    meal.description,
                    style: textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.xl)),
                  child: Divider(color: scheme.outline.withValues(alpha: 0.5)),
                ),
                // Selling options — not applicable to a returned/salvage
                // meal, which is already tied to one specific batch/price.
                if (returnedMeal == null && meal.sellingOptions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpace.l,
                    ).add(const EdgeInsetsDirectional.only(top: AppSpace.l)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('خيارات البيع', style: textTheme.titleLarge),
                        const SizedBox(height: AppSpace.m),
                        SellingOptionSelector(
                          options: meal.sellingOptions,
                          selectedOptionId: selectedSellingOptionId,
                          onSelected: cubit.selectSellingOption,
                        ),
                      ],
                    ),
                  ),
                // Quantity & price row
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.xl)),
                  child: Row(
                    // The mockup mirrors this row (stepper at the reading
                    // start / price at the reading end) rather than
                    // following plain reading order — matches screen.png.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityStepper(
                        quantity: quantity,
                        onIncrement: cubit.incrementQuantity,
                        onDecrement: cubit.decrementQuantity,
                        maxQuantity: returnedMeal?.quantity,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'السعر الإجمالي',
                            style: textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                          Text(
                            '${totalPrice.toStringAsFixed(0)} ${l10n.currencySuffix}',
                            style: textTheme.headlineMedium?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (returnedMeal != null)
                            Text(
                              '${(returnedMeal!.originalPrice * quantity).toStringAsFixed(0)} ${l10n.currencySuffix}',
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Notes
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                  ).add(const EdgeInsetsDirectional.only(top: AppSpace.xl)),
                  child: MealNoteField(
                    value: note,
                    onChanged: cubit.updateNote,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Back button
        PositionedDirectional(
          top: AppSpace.s,
          start: AppSpace.s,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
        // Report — only meaningful for meals from a delivered order (the
        // backend rejects otherwise), but the entry point lives here
        // regardless since there's no other screen this action belongs to.
        PositionedDirectional(
          top: AppSpace.s,
          end: AppSpace.s,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.flag_outlined),
                tooltip: 'الإبلاغ عن الوجبة',
                onPressed: () => _showReportDialog(context, cubit),
              ),
            ),
          ),
        ),
        // Bottom action bar
        PositionedDirectional(
          bottom: 0,
          start: 0,
          end: 0,
          child: Container(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.9),
              border: BorderDirectional(
                top: BorderSide(color: scheme.outline.withValues(alpha: 0.2)),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (returnedMeal == null && meal.sellingOptions.isEmpty)
                      ? null
                      : cubit.addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: AppSpace.l,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sheet),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('إضافة إلى السلة'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _showReportDialog(BuildContext context, MealDetailsCubit cubit) async {
  final controller = TextEditingController();
  final message = await showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('الإبلاغ عن الوجبة'),
      content: TextField(
        controller: controller,
        maxLines: 3,
        maxLength: 500,
        decoration: const InputDecoration(hintText: 'وضّح سبب الإبلاغ...'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(controller.text.trim()),
          child: const Text('إرسال'),
        ),
      ],
    ),
  );
  controller.dispose();
  if (message == null || message.isEmpty || !context.mounted) return;

  final result = await cubit.report(message);
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        result.fold((_) => 'تم إرسال البلاغ، شكراً لك.', (exception) => exception.message),
      ),
    ),
  );
}

class _MealDetailsSkeleton extends StatelessWidget {
  const _MealDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 240, borderRadius: 24),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 28, width: 200),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 72, borderRadius: 24),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 16),
        SizedBox(height: AppSpace.s),
        LoadingSkeleton(height: 16, width: 220),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 44, width: 260, borderRadius: 999),
      ],
    );
  }
}
