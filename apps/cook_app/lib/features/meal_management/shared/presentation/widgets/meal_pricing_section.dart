import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../bloc/meal_variation_draft.dart';
import 'meal_variation_row.dart';

/// "التسعير والخيارات" — a toggle switch between a single price and a list
/// of size/price variations. The two are mutually exclusive: only one is
/// ever shown at a time (CK-07's business rule), never both.
class MealPricingSection extends StatelessWidget {
  const MealPricingSection({
    super.key,
    required this.sectionTitle,
    required this.toggleLabel,
    required this.sellWithVariations,
    required this.onToggleChanged,
    required this.priceLabel,
    required this.currencySuffix,
    required this.priceInput,
    required this.onPriceChanged,
    required this.priceError,
    required this.variations,
    required this.variationSizeHint,
    required this.onVariationLabelChanged,
    required this.onVariationPriceChanged,
    required this.onVariationRemoved,
    required this.onVariationAdded,
    required this.addVariationLabel,
    required this.variationsError,
  });

  final String sectionTitle;
  final String toggleLabel;
  final bool sellWithVariations;
  final ValueChanged<bool> onToggleChanged;

  final String priceLabel;
  final String currencySuffix;
  final String priceInput;
  final ValueChanged<String> onPriceChanged;
  final String? priceError;

  final List<MealVariationDraft> variations;
  final String variationSizeHint;
  final void Function(String localId, String label) onVariationLabelChanged;
  final void Function(String localId, String priceInput) onVariationPriceChanged;
  final void Function(String localId) onVariationRemoved;
  final VoidCallback onVariationAdded;
  final String addVariationLabel;
  final String? variationsError;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return FormSectionCard(
      title: sectionTitle,
      children: [
        Row(
          children: [
            Expanded(child: Text(toggleLabel, style: Theme.of(context).textTheme.bodyLarge)),
            Switch(value: sellWithVariations, onChanged: onToggleChanged),
          ],
        ),
        const SizedBox(height: AppSpace.s),
        if (sellWithVariations) ...[
          for (final variation in variations)
            MealVariationRow(
              key: ValueKey(variation.localId),
              label: variation.label,
              sizeHint: variationSizeHint,
              onLabelChanged: (value) => onVariationLabelChanged(variation.localId, value),
              priceInput: variation.priceInput,
              currencySuffix: currencySuffix,
              onPriceChanged: (value) => onVariationPriceChanged(variation.localId, value),
              onRemove: () => onVariationRemoved(variation.localId),
            ),
          OutlinedButton.icon(
            onPressed: onVariationAdded,
            icon: const Icon(Icons.add),
            label: Text(addVariationLabel),
          ),
          if (variationsError != null) ...[
            const SizedBox(height: AppSpace.xs),
            Text(variationsError!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.error)),
          ],
        ] else
          TextFormField(
            initialValue: priceInput,
            onChanged: onPriceChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              labelText: priceLabel,
              suffixText: currencySuffix,
              errorText: priceError,
            ),
          ),
      ],
    );
  }
}
