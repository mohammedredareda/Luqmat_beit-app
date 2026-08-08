import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// "الطلب المسبق" — required pre-order lead time in hours. Numeric input
/// stays LTR even inside the RTL layout (mockup convention for numerals).
class MealPreorderTimeField extends StatelessWidget {
  const MealPreorderTimeField({
    super.key,
    required this.sectionTitle,
    required this.label,
    required this.unitLabel,
    required this.value,
    required this.onChanged,
    required this.errorText,
  });

  final String sectionTitle;
  final String label;
  final String unitLabel;
  final String value;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: sectionTitle,
      children: [
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            labelText: label,
            suffixText: unitLabel,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
