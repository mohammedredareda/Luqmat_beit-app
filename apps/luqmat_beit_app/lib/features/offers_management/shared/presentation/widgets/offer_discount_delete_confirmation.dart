import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../delete_discount/presentation/bloc/delete_discount_cubit.dart';
import '../../../delete_discount/presentation/bloc/delete_discount_state.dart';
import '../../../delete_offer/presentation/bloc/delete_offer_cubit.dart';
import '../../../delete_offer/presentation/bloc/delete_offer_state.dart';

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
    message: l10n.deleteOfferConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteOfferCubit>();
  DeleteOfferState? finalState;
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => finalState = state,
      failure: (_) => finalState = state,
    );
  });

  // Blocking spinner for the duration of the delete request — also keeps
  // the card's Edit/Delete buttons unreachable while it's in flight, so a
  // stray tap can't race a since-deleted item's edit screen.
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator())),
  );

  await cubit.delete(offerId);
  await subscription.cancel();
  await cubit.close();

  if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

  finalState?.whenOrNull(
    success: (_) => onDeleted(),
    failure: (exception) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message)));
      }
    },
  );
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
    message: l10n.deleteDiscountConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteDiscountCubit>();
  DeleteDiscountState? finalState;
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => finalState = state,
      failure: (_) => finalState = state,
    );
  });

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator())),
  );

  await cubit.delete(discountId);
  await subscription.cancel();
  await cubit.close();

  if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

  finalState?.whenOrNull(
    success: (_) => onDeleted(),
    failure: (exception) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message)));
      }
    },
  );
}
