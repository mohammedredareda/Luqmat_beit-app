import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../delete_discount/presentation/bloc/delete_discount_cubit.dart';
import '../../../delete_offer/presentation/bloc/delete_offer_cubit.dart';

/// Mirrors `showDeleteMealConfirmation` one-for-one — the single entry
/// point every offer-card/edit-offer-page delete affordance calls.
Future<void> showDeleteOfferConfirmation(
  BuildContext context, {
  required String offerId,
  required VoidCallback onDeleted,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await ConfirmationDialog.show(
    context,
    title: l10n.deleteOfferConfirmTitle,
    body: l10n.deleteOfferConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteOfferCubit>();
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => onDeleted(),
      failure: (exception) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message)));
        }
      },
    );
  });

  await cubit.delete(offerId);
  await subscription.cancel();
  await cubit.close();
}

/// Mirrors `showDeleteOfferConfirmation` for discounts.
Future<void> showDeleteDiscountConfirmation(
  BuildContext context, {
  required String discountId,
  required VoidCallback onDeleted,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await ConfirmationDialog.show(
    context,
    title: l10n.deleteDiscountConfirmTitle,
    body: l10n.deleteDiscountConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteDiscountCubit>();
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => onDeleted(),
      failure: (exception) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message)));
        }
      },
    );
  });

  await cubit.delete(discountId);
  await subscription.cancel();
  await cubit.close();
}
