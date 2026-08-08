import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One "size + price" row inside the variations list.
class MealVariationRow extends StatelessWidget {
  const MealVariationRow({
    super.key,
    required this.label,
    required this.sizeHint,
    required this.onLabelChanged,
    required this.priceInput,
    required this.currencySuffix,
    required this.onPriceChanged,
    required this.onRemove,
  });

  final String label;
  final String sizeHint;
  final ValueChanged<String> onLabelChanged;
  final String priceInput;
  final String currencySuffix;
  final ValueChanged<String> onPriceChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              initialValue: label,
              onChanged: onLabelChanged,
              decoration: InputDecoration(hintText: sizeHint),
            ),
          ),
          const SizedBox(width: AppSpace.s),
          SizedBox(
            width: 96,
            child: TextFormField(
              initialValue: priceInput,
              onChanged: onPriceChanged,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              decoration: InputDecoration(suffixText: currencySuffix),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.delete_outline, color: scheme.error),
            tooltip: 'remove',
          ),
        ],
      ),
    );
  }
}
