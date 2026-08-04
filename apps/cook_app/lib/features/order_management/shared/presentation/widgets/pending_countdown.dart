import 'dart:async';

import 'package:flutter/material.dart';

/// CK-25's client-side countdown — a live mm:ss readout of the time left
/// before a `pending` order's timeout expires (25% of `Total expected
/// time`). Purely informational: the server, not this widget, is what
/// actually cancels the order — this just gives the cook visible time
/// pressure on the list card and the pending decision screen.
class PendingCountdown extends StatefulWidget {
  const PendingCountdown({super.key, required this.expiresAt, this.onExpired});

  final DateTime expiresAt;
  final VoidCallback? onExpired;

  @override
  State<PendingCountdown> createState() => _PendingCountdownState();
}

class _PendingCountdownState extends State<PendingCountdown> {
  late Duration _remaining = _computeRemaining();
  Timer? _timer;

  Duration _computeRemaining() {
    final diff = widget.expiresAt.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = _computeRemaining();
      setState(() => _remaining = remaining);
      if (remaining == Duration.zero) {
        _timer?.cancel();
        widget.onExpired?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, size: 16, color: scheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          '$minutes:$seconds',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
        ),
      ],
    );
  }
}
