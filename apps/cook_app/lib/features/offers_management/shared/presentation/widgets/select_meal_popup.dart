import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../bloc/select_meal_cubit.dart';
import '../bloc/select_meal_state.dart';

/// One component reused by both the offer and discount flows,
/// parameterized only by [excludedMealIds] — all type-specific branching
/// (whether a selling-option dialog follows) lives in the caller. Tapping
/// a card selects it (mirroring the `select_meal_popup` mockup's
/// select-then-confirm pattern); resolves to the selected [MealEntity]
/// once "إضافة" is pressed, or `null` on cancel/dismiss.
Future<MealEntity?> showSelectMealPopup(
  BuildContext context, {
  required Set<String> excludedMealIds,
}) {
  return showDialog<MealEntity>(
    context: context,
    builder: (_) => BlocProvider(
      create: (_) => getIt<SelectMealCubit>()..load(),
      child: SelectMealPopup(excludedMealIds: excludedMealIds),
    ),
  );
}

class SelectMealPopup extends StatefulWidget {
  const SelectMealPopup({super.key, required this.excludedMealIds});

  final Set<String> excludedMealIds;

  @override
  State<SelectMealPopup> createState() => _SelectMealPopupState();
}

class _SelectMealPopupState extends State<SelectMealPopup> {
  String _query = '';
  MealEntity? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(AppSpace.l),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl, vertical: AppSpace.l),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: scheme.surfaceContainerHighest)),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.selectMealPopupTitle, style: textTheme.titleMedium)),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl, vertical: AppSpace.l),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: l10n.selectMealSearchHint,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(AppSpace.xl, 0, AppSpace.xl, AppSpace.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.selectMealAvailableLabel,
                      style: textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpace.m),
                    BlocBuilder<SelectMealCubit, SelectMealState>(
                      builder: (context, state) => state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSpace.xxl),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        loaded: (meals) {
                          final filtered = meals
                              .where((m) => !widget.excludedMealIds.contains(m.id))
                              .where((m) => m.name.contains(_query))
                              .toList();
                          if (filtered.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
                              child: Center(child: Text(l10n.selectMealEmptyResults)),
                            );
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpace.m,
                              crossAxisSpacing: AppSpace.m,
                              childAspectRatio: 0.78,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final meal = filtered[index];
                              return _MealTile(
                                meal: meal,
                                selected: _selected?.id == meal.id,
                                onTap: () => setState(() => _selected = meal),
                              );
                            },
                          );
                        },
                        error: (exception) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(exception.message, textAlign: TextAlign.center),
                              const SizedBox(height: AppSpace.s),
                              OutlinedButton(
                                onPressed: () => context.read<SelectMealCubit>().load(),
                                child: Text(l10n.retryLabel),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(AppSpace.xl),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: scheme.surfaceContainerHighest)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _selected == null ? null : () => Navigator.of(context).pop(_selected),
                      child: Text(l10n.selectMealAddCta),
                    ),
                  ),
                  const SizedBox(width: AppSpace.m),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.cancelLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  const _MealTile({required this.meal, required this.selected, required this.onTap});

  final MealEntity meal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: selected ? scheme.primary : scheme.outline, width: selected ? 2 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      meal.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: scheme.surfaceContainerHighest,
                        child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                  if (selected)
                    PositionedDirectional(
                      top: AppSpace.xs,
                      start: AppSpace.xs,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
                        child: Icon(Icons.check, size: 16, color: scheme.onPrimary),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: AppSpace.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      meal.name,
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpace.xs),
                    Text(meal.startingPrice.toStringAsFixed(0), style: AppText.price(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
