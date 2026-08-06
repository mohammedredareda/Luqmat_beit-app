import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Optional note field for the meal (≤100 chars — [NoteLengthValidator]'s
/// meal-note rule, shared with the cook app so both agree on the limit).
class MealNoteField extends StatefulWidget {
  const MealNoteField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<MealNoteField> createState() => _MealNoteFieldState();
}

class _MealNoteFieldState extends State<MealNoteField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isValid = NoteLengthValidator.isMealNoteValid(widget.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملاحظات (اختياري)', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpace.s),
        TextField(
          maxLines: 3,
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: 'مثال: بدون بصل، حار قليلاً...',
            filled: true,
            fillColor: scheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.image),
              borderSide: BorderSide(color: scheme.outline),
            ),
            errorText: isValid
                ? null
                : 'الملاحظة يجب ألا تتجاوز ${NoteLengthValidator.mealNoteMax} حرفاً',
          ),
        ),
        const SizedBox(height: AppSpace.xs),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            '${widget.value.length}/${NoteLengthValidator.mealNoteMax}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isValid ? scheme.onSurfaceVariant : scheme.error,
                ),
          ),
        ),
      ],
    );
  }
}
