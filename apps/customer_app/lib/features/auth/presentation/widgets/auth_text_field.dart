import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Shared labeled text field matching the auth mockups' input style
/// (2px outlined border, leading icon, Sumac focus color).
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.textDirection,
    this.maxLines = 1,
    this.trailing,
  });

  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final int maxLines;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpace.xs),
        TextField(
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textDirection: textDirection,
          maxLines: obscureText ? 1 : maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: scheme.onSurfaceVariant),
            suffixIcon: trailing,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: scheme.outline, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
