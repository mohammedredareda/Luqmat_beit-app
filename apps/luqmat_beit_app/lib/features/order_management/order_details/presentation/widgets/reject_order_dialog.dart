import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// CK-18's Reject dialog — mirrors [ConfirmationDialog]'s R-20/R-08 shape
/// (Cancel default-focused text button, Reject as an error-outlined
/// button) but adds an optional free-text rejection reason field, which
/// [ConfirmationDialog] has no room for. The reason is never required —
/// leaving it blank still rejects the order, with the data layer filling
/// in an automatic placeholder reason server-side. Collects the decision
/// only — no network call happens here; the caller's Bloc drives the R-19
/// submitting spinner after this dialog has already closed.
class RejectOrderDialog extends StatefulWidget {
  const RejectOrderDialog({super.key, required this.orderId});

  final String orderId;

  /// Resolves to the trimmed rejection reason (possibly empty — the field
  /// is optional), or `null` on cancel/dismiss.
  static Future<String?> show(BuildContext context, {required String orderId}) {
    return showDialog<String>(
      context: context,
      builder: (_) => RejectOrderDialog(orderId: orderId),
    );
  }

  @override
  State<RejectOrderDialog> createState() => _RejectOrderDialogState();
}

class _RejectOrderDialogState extends State<RejectOrderDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(l10n.rejectOrderDialogTitle(widget.orderId)),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 2,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: l10n.rejectionReasonLabel,
          hintText: l10n.rejectionReasonHint,
        ),
      ),
      actions: [
        TextButton(
          autofocus: true,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelLabel),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          style: OutlinedButton.styleFrom(
            foregroundColor: scheme.error,
            side: BorderSide(color: scheme.error, width: 1.5),
          ),
          child: Text(l10n.rejectOrderConfirmCta),
        ),
      ],
    );
  }
}
