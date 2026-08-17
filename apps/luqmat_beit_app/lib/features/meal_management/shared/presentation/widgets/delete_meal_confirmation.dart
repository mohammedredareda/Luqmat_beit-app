import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../delete_meal/presentation/bloc/delete_meal_cubit.dart';
import '../../../delete_meal/presentation/bloc/delete_meal_state.dart';

/// Popped by `edit_meal_page.dart` when the meal was deleted from within
/// the edit form itself, so `view_menu_page.dart`'s `onEdit` callback can
/// tell that apart from a normal save (which pops the updated [MealEntity]
/// directly) and remove the right card instead of trying to replace it.
class MealDeleted {
  const MealDeleted(this.mealId);
  final String mealId;
}

/// CK-09's delete confirmation dialog — the single entry point both
/// `view_menu_page.dart`'s meal-card delete icon and `edit_meal_page.dart`'s
/// outlined delete button call, so the dialog/cubit wiring exists in
/// exactly one place. Shows the R-08-compliant outlined-error confirm
/// dialog, and only on confirm drives a fresh [DeleteMealCubit] instance.
Future<void> showDeleteMealConfirmation(
  BuildContext context, {
  required String mealId,
  required VoidCallback onDeleted,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await ConfirmationDialog.show(
    context,
    title: l10n.deleteMealConfirmTitle,
    message: l10n.deleteMealConfirmBody,
    confirmLabel: l10n.confirmDeleteCta,
    cancelLabel: l10n.cancelLabel,
    isDestructive: true,
  );
  if (confirmed != true || !context.mounted) return;

  final cubit = getIt<DeleteMealCubit>();
  DeleteMealState? finalState;
  final subscription = cubit.stream.listen((state) {
    state.whenOrNull(
      success: (_) => finalState = state,
      failure: (_) => finalState = state,
    );
  });

  // Blocking spinner for the duration of the delete request. Dismissed
  // unconditionally right after `cubit.delete` below returns — NOT from
  // inside the stream listener, which raced the dialog's own push and
  // could leave it stuck on screen despite a successful delete.
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator())),
  );

  await cubit.delete(mealId);
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
