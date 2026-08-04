import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../shared/presentation/widgets/offer_discount_card.dart';
import '../../../shared/presentation/widgets/offer_discount_delete_confirmation.dart';
import '../../../shared/presentation/widgets/select_offer_type_sheet.dart';
import '../bloc/view_offers_cubit.dart';
import '../bloc/view_offers_state.dart';
import '../widgets/view_offers_skeleton.dart';

/// CK-11 View Offers & Discounts.
class ViewOffersPage extends StatelessWidget {
  const ViewOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ViewOffersCubit>()..load(),
      child: const _ViewOffersView(),
    );
  }
}

Future<void> _onAddPressed(BuildContext context) async {
  final choice = await showSelectOfferTypeSheet(context);
  if (choice == null || !context.mounted) return;
  final route = choice == OfferTypeChoice.offer ? '/offers/create' : '/discounts/create';
  context.push(route).then((_) {
    if (context.mounted) context.read<ViewOffersCubit>().load();
  });
}

class _ViewOffersView extends StatelessWidget {
  const _ViewOffersView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luqmat Beit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l10n.notificationsTitle,
          ),
        ],
      ),
      body: BlocBuilder<ViewOffersCubit, ViewOffersState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const ViewOffersSkeleton(),
          loaded: (offers, discounts) => _LoadedBody(offers: offers, discounts: discounts),
          error: (exception) => _ErrorBody(message: exception.message),
        ),
      ),
    );
  }
}

enum _OfferFilter { all, active, expired }

bool _offerIsExpired(OfferEntity offer) => offer.remainingDays <= 0;

bool _discountIsExpired(DiscountEntity discount) =>
    (discount.remainingDays != null && discount.remainingDays! <= 0) ||
    (discount.remainingUsage != null && discount.remainingUsage! <= 0);

class _LoadedBody extends StatefulWidget {
  const _LoadedBody({required this.offers, required this.discounts});

  final List<OfferEntity> offers;
  final List<DiscountEntity> discounts;

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody> {
  _OfferFilter _filter = _OfferFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (widget.offers.isEmpty && widget.discounts.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(AppSpace.l),
        children: [
          _Header(l10n: l10n),
          const SizedBox(height: AppSpace.l),
          EmptyState(
            icon: Icons.local_offer_outlined,
            iconBackgroundColor: AppColors.sumacContainer,
            iconColor: AppColors.sumac,
            heading: l10n.emptyOffersHeading,
            body: l10n.emptyOffersBody,
            ctaLabel: l10n.addOfferOrDiscountCta,
            onCtaPressed: () => _onAddPressed(context),
          ),
        ],
      );
    }

    bool matchesFilter(bool expired, bool isActive) => switch (_filter) {
          _OfferFilter.all => true,
          _OfferFilter.active => !expired && isActive,
          _OfferFilter.expired => expired,
        };

    final discounts = widget.discounts
        .where((d) => matchesFilter(_discountIsExpired(d), d.isActive))
        .toList();
    final offers =
        widget.offers.where((o) => matchesFilter(_offerIsExpired(o), o.isActive)).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.xl),
      children: [
        _Header(l10n: l10n),
        const SizedBox(height: AppSpace.l),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _FilterChip(
                label: l10n.filterAllLabel,
                selected: _filter == _OfferFilter.all,
                onTap: () => setState(() => _filter = _OfferFilter.all),
              ),
              const SizedBox(width: AppSpace.s),
              _FilterChip(
                label: l10n.filterActiveLabel,
                selected: _filter == _OfferFilter.active,
                onTap: () => setState(() => _filter = _OfferFilter.active),
              ),
              const SizedBox(width: AppSpace.s),
              _FilterChip(
                label: l10n.filterExpiredLabel,
                selected: _filter == _OfferFilter.expired,
                onTap: () => setState(() => _filter = _OfferFilter.expired),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.l),
        for (final discount in discounts) ...[
          DiscountCard(
            discount: discount,
            onEdit: () => context.push('/discounts/${discount.id}/edit').then((_) {
              if (context.mounted) context.read<ViewOffersCubit>().load();
            }),
            onDelete: () => showDeleteDiscountConfirmation(
              context,
              discountId: discount.id,
              onDeleted: () => context.read<ViewOffersCubit>().load(),
            ),
          ),
          const SizedBox(height: AppSpace.l),
        ],
        for (final offer in offers) ...[
          OfferCard(
            offer: offer,
            onEdit: () => context.push('/offers/${offer.id}/edit').then((_) {
              if (context.mounted) context.read<ViewOffersCubit>().load();
            }),
            onDelete: () => showDeleteOfferConfirmation(
              context,
              offerId: offer.id,
              onDeleted: () => context.read<ViewOffersCubit>().load(),
            ),
          ),
          const SizedBox(height: AppSpace.l),
        ],
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.card),
          onTap: () => _onAddPressed(context),
          child: Container(
            constraints: const BoxConstraints(minHeight: 140),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: scheme.outline, width: 2, style: BorderStyle.solid),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpace.s),
                    Text(l10n.addOfferOrDiscountCta, style: textTheme.labelLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.offersTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 40,
                height: 48 / 40,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          l10n.offersSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.l),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => _onAddPressed(context),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            icon: const Icon(Icons.add),
            label: Text(l10n.addOfferOrDiscountCta),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected ? AppColors.sumacContainer : scheme.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? scheme.primary.withValues(alpha: 0.2) : scheme.outline),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.s),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: AppSpace.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.l),
            OutlinedButton(
              onPressed: () => context.read<ViewOffersCubit>().load(),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
