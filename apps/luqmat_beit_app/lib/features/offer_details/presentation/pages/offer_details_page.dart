import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../../../meal_details/domain/usecases/get_meal_details.dart';
import '../../domain/usecases/add_offer_to_cart.dart';
import '../cubit/offer_details_cubit.dart';
import '../cubit/offer_details_state.dart';
import '../widgets/offer_included_meal_tile.dart';

/// Details screen for a multi-meal bundle offer (see the "offers detiels"
/// mockup under AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module). Reached at
/// `/offer/:offerId` with `extra: bundle` — there's no `GET offer by id`
/// endpoint, so the bundle comes from whichever list (Home/Search) already
/// fetched it, same as `MealDetailsPage`'s `returnedMeal` extra.
class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key, required this.bundle});

  final OfferBundleEntity bundle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OfferDetailsCubit(AddOfferToCart(getIt())),
      child: _OfferDetailsView(bundle: bundle),
    );
  }
}

class _OfferDetailsView extends StatelessWidget {
  const _OfferDetailsView({required this.bundle});

  final OfferBundleEntity bundle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final originalTotal =
        bundle.meals.fold<double>(0, (sum, meal) => sum + meal.price);
    final hasSavings = originalTotal > bundle.totalPrice && originalTotal > 0;
    final savingsPercent = hasSavings
        ? (((originalTotal - bundle.totalPrice) / originalTotal) * 100).round()
        : 0;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: BlocListener<OfferDetailsCubit, OfferDetailsState>(
          listener: (context, state) {
            final cubit = context.read<OfferDetailsCubit>();
            if (state is OfferDetailsAddedToCart) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text('تمت إضافة العرض إلى السلة'),
                    backgroundColor: scheme.primary,
                  ),
                );
              cubit.acknowledgeAddedToCart();
            } else if (state is OfferDetailsFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text(state.exception.message)));
              cubit.acknowledgeFailure();
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.only(bottom: 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ImageCollage(
                          meals: bundle.meals,
                          hasSavings: hasSavings,
                          savingsPercent: savingsPercent),
                      const SizedBox(height: AppSpace.xl + AppSpace.xl),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpace.l),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bundle.name,
                              style: textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            _OfferChefCard(bundle: bundle),
                            const SizedBox(height: AppSpace.m),
                            Text(
                              bundle.description,
                              style: textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: AppSpace.xl),
                            Text('يتضمن هذا العرض',
                                style: textTheme.titleLarge),
                            const SizedBox(height: AppSpace.m),
                            for (var i = 0; i < bundle.meals.length; i++) ...[
                              OfferIncludedMealTile(meal: bundle.meals[i]),
                              if (i != bundle.meals.length - 1)
                                const SizedBox(height: AppSpace.s),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                top: AppSpace.s,
                start: AppSpace.s,
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
              PositionedDirectional(
                bottom: 0,
                start: 0,
                end: 0,
                child: BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
                  builder: (context, state) {
                    final totalPrice = bundle.totalPrice * state.quantity;
                    return Container(
                      padding: const EdgeInsetsDirectional.all(AppSpace.l),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        border: BorderDirectional(
                          top: BorderSide(
                              color: scheme.outline.withValues(alpha: 0.2)),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'السعر الإجمالي',
                                      style: textTheme.bodySmall?.copyWith(
                                          color: scheme.onSurfaceVariant),
                                    ),
                                    Text(
                                      '${totalPrice.toStringAsFixed(0)} ${l10n.currencySuffix}',
                                      style: textTheme.headlineMedium?.copyWith(
                                        color: scheme.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                _OfferQuantityStepper(
                                  quantity: state.quantity,
                                  onIncrement: context
                                      .read<OfferDetailsCubit>()
                                      .incrementQuantity,
                                  onDecrement: context
                                      .read<OfferDetailsCubit>()
                                      .decrementQuantity,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpace.m),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: state is OfferDetailsSubmitting
                                    ? null
                                    : () => context
                                        .read<OfferDetailsCubit>()
                                        .addToCart(bundle.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: scheme.primary,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          vertical: AppSpace.l),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.sheet),
                                  ),
                                ),
                                icon: state is OfferDetailsSubmitting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.shopping_bag_outlined),
                                label: const Text('أضف إلى السلة'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageCollage extends StatelessWidget {
  const _ImageCollage(
      {required this.meals,
      required this.hasSavings,
      required this.savingsPercent});

  final List<OfferBundleMealEntity> meals;
  final bool hasSavings;
  final int savingsPercent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget image(String url) => Container(
          color: scheme.surfaceContainerHighest,
          child: url.isEmpty
              ? null
              : Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
        );

    Widget collage;
    if (meals.isEmpty) {
      collage = image('');
    } else if (meals.length == 1) {
      collage = image(meals[0].imageUrl);
    } else if (meals.length == 2) {
      collage = Row(
        children: [
          Expanded(flex: 2, child: image(meals[0].imageUrl)),
          const SizedBox(width: 2),
          Expanded(child: image(meals[1].imageUrl)),
        ],
      );
    } else {
      collage = Row(
        children: [
          Expanded(flex: 2, child: image(meals[0].imageUrl)),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Expanded(child: image(meals[1].imageUrl)),
                const SizedBox(height: 2),
                Expanded(child: image(meals[2].imageUrl)),
              ],
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: collage),
          if (hasSavings)
            PositionedDirectional(
              bottom: -AppSpace.xl,
              end: AppSpace.l,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.m,
                  vertical: AppSpace.s,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_offer,
                        size: 18, color: Colors.white),
                    const SizedBox(width: AppSpace.xs),
                    Text(
                      'توفير $savingsPercent٪',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Resolves the bundle's cook by fetching full details for its first
/// included meal — `OfferBundleEntity` itself carries no cook reference
/// (neither Home's nor Search's `/offers` response includes one, confirmed
/// live), but `GET /user/customer/meal/:id` does. Reuses the existing
/// `GetMealDetails` usecase rather than adding a new one. Renders nothing
/// while loading, on failure, or when the bundle has no meals — same
/// "hide rather than fabricate" behavior as before.
class _OfferChefCard extends StatefulWidget {
  const _OfferChefCard({required this.bundle});

  final OfferBundleEntity bundle;

  @override
  State<_OfferChefCard> createState() => _OfferChefCardState();
}

class _OfferChefCardState extends State<_OfferChefCard> {
  ChefSummaryEntity? _chef;

  @override
  void initState() {
    super.initState();
    _resolveChef();
  }

  Future<void> _resolveChef() async {
    if (widget.bundle.meals.isEmpty) return;
    // Constructed inline, matching `MealDetailsCubit`'s existing pattern —
    // `GetMealDetails` isn't individually get_it-registered.
    final getMealDetails = GetMealDetails(getIt());
    final result = await getMealDetails(widget.bundle.meals.first.mealId);
    if (!mounted) return;
    result.fold(
      (meal) => setState(() => _chef = ChefSummaryEntity(
            id: meal.cookId,
            name: meal.cookName,
            avatarUrl: meal.cookAvatarUrl ?? '',
            rating: 0,
            ratingCount: 0,
            distanceKm: 0,
          )),
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final chef = _chef;
    if (chef == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpace.m),
      child: _ChefCard(chef: chef),
    );
  }
}

class _ChefCard extends StatelessWidget {
  const _ChefCard({required this.chef});

  final ChefSummaryEntity chef;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.m),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.sheet),
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 48,
              height: 48,
              child: chef.avatarUrl.isEmpty
                  ? Container(color: scheme.surfaceContainerHighest)
                  : Image.network(
                      chef.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: scheme.surfaceContainerHighest),
                    ),
            ),
          ),
          const SizedBox(width: AppSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chef.name, style: textTheme.bodyLarge),
                const SizedBox(height: AppSpace.xs),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xFFB97A1E)),
                    const SizedBox(width: AppSpace.xs),
                    Text(
                      '${chef.rating.toStringAsFixed(1)} (${chef.ratingCount} تقييم)',
                      style: textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push('/chef/${chef.id}'),
            style: TextButton.styleFrom(
              // `primaryFixed` isn't set on this app's `ColorScheme` (only
              // the Sumac primary/primaryContainer pair actually used
              // throughout this codebase is) — it was silently falling
              // back to Flutter's generic Material-3 default, rendering
              // invisible/mismatched text. Never caught before because
              // this card never actually rendered until now.
              foregroundColor: scheme.primary,
              backgroundColor: scheme.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button)),
            ),
            child: const Text('عرض الملف'),
          ),
        ],
      ),
    );
  }
}

class _OfferQuantityStepper extends StatelessWidget {
  const _OfferQuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final atMin = quantity <= 1;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.xs),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
              icon: Icons.remove,
              onTap: atMin ? null : onDecrement,
              scheme: scheme),
          Padding(
            padding:
                const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.m),
            child: Text(
              '$quantity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _StepperButton(icon: Icons.add, onTap: onIncrement, scheme: scheme),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton(
      {required this.icon, required this.onTap, required this.scheme});

  final IconData icon;
  final VoidCallback? onTap;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surface,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon,
              size: 20, color: onTap == null ? scheme.outline : scheme.primary),
        ),
      ),
    );
  }
}
