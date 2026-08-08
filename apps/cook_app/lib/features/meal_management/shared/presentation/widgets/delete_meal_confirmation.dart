import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../delete_meal/presentation/bloc/delete_meal_cubit.dart';

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

  await cubit.delete(mealId);
  await subscription.cancel();
  await cubit.close();
}
