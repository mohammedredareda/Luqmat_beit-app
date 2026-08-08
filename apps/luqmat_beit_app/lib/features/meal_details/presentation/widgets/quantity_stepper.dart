import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The rounded quantity control from the mockup's "Quantity & Price Row".
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.xs),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: scheme.outline, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(icon: Icons.add, onTap: onIncrement, scheme: scheme),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.m),
            child: Text(
              '$quantity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          _StepperButton(icon: Icons.remove, onTap: onDecrement, scheme: scheme),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap, required this.scheme});

  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, color: scheme.onSurface),
      ),
    );
  }
}
