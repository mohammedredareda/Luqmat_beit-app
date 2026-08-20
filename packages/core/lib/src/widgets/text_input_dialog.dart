import 'package:flutter/material.dart';

/// A single-field text-input dialog (e.g. "describe the issue") that owns
/// its [TextEditingController] internally — created in [State.initState],
/// disposed in [State.dispose] — rather than the caller creating one and
/// disposing it itself right after [show] returns. Disposing that early
/// races the dialog route's own exit transition, which can still be
/// mid-rebuild referencing the controller, and crashes with "A
/// TextEditingController was used after being disposed" cascading into
/// "'_dependents.isEmpty': is not true". Tying disposal to this widget's
/// own Element lifecycle instead means it only happens once Flutter has
/// actually finished unmounting it.
class TextInputDialog extends StatefulWidget {
  const TextInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    this.maxLines = 3,
    this.maxLength,
    this.confirmLabel = 'إرسال',
    this.cancelLabel = 'إلغاء',
  });

  final String title;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final String confirmLabel;
  final String cancelLabel;

  /// Shows the dialog and returns the trimmed entered text, or `null` if
  /// cancelled/dismissed.
  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String hintText,
    int maxLines = 3,
    int? maxLength,
    String confirmLabel = 'إرسال',
    String cancelLabel = 'إلغاء',
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => TextInputDialog(
        title: title,
        hintText: hintText,
        maxLines: maxLines,
        maxLength: maxLength,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: TextAlign.right,
        decoration: InputDecoration(hintText: widget.hintText),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
