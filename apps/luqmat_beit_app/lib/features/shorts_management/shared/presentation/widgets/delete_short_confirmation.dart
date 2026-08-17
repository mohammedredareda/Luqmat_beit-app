import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../delete_short/presentation/bloc/delete_short_cubit.dart';
import '../../../delete_short/presentation/bloc/delete_short_state.dart';

/// Mockup `_1`'s delete confirmation modal — the single entry point
/// `my_shorts_page.dart`'s gallery-card delete icon calls, so the dialog/
/// cubit wiring exists in exactly one place. Copies
/// `delete_meal_confirmation.dart`'s exact structure (R-08-compliant
/// outlined-error confirm dialog, blocking spinner for the delete request).
Future<void> showDeleteShortConfirmation(
  BuildContext context, {
  required String shortId,
  required VoidCallback onDeleted,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await ConfirmationDialog.show(
    context,
    title: l10n.deleteShortConfirmTitle,
    message: l10n.deleteShortConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteShortCubit>();
  DeleteShortState? finalState;
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => finalState = state,
      failure: (_) => finalState = state,
    );
  });

  // Blocking spinner for the duration of the delete request. Dismissed
  // unconditionally right after `cubit.delete` below returns — NOT from
  // inside the stream listener (see `delete_meal_confirmation.dart`'s doc
  // comment for why that races the dialog's own push).
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator())),
  );

  await cubit.delete(shortId);
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
