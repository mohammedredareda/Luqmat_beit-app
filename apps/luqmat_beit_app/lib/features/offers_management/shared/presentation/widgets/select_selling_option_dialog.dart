import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

Future<SellingOptionEntity?> showSelectSellingOptionDialog(
  BuildContext context, {
  required MealEntity meal,
}) {
  return showDialog<SellingOptionEntity>(
    context: context,
    builder: (_) => SelectSellingOptionDialog(meal: meal),
  );
}

class SelectSellingOptionDialog extends StatefulWidget {
  const SelectSellingOptionDialog({super.key, required this.meal});

  final MealEntity meal;

  @override
  State<SelectSellingOptionDialog> createState() => _SelectSellingOptionDialogState();
}

class _SelectSellingOptionDialogState extends State<SelectSellingOptionDialog> {
  late SellingOptionEntity _selected = widget.meal.sellingOptions.first;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(l10n.selectSellingOptionDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.mealNameFieldLabel, style: textTheme.bodySmall),
          const SizedBox(height: AppSpace.xs),
          Text(widget.meal.name, style: textTheme.bodyLarge),
          const SizedBox(height: AppSpace.m),
          Text(l10n.sellingOptionsListLabel, style: textTheme.bodySmall),
          RadioGroup<SellingOptionEntity>(
            groupValue: _selected,
            onChanged: (value) => setState(() => _selected = value!),
            child: Column(
              children: [
                for (final option in widget.meal.sellingOptions)
                  RadioListTile<SellingOptionEntity>(
                    value: option,
                    contentPadding: EdgeInsets.zero,
                    title: Text(option.label),
                    secondary:
                        Text(option.price.toStringAsFixed(0), style: AppText.price(context)),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelLabel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: Text(l10n.confirmSellingOptionCta),
        ),
      ],
    );
  }
}
