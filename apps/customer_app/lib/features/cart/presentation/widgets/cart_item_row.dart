import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// A single cart line: meal image, name, price, a quantity stepper, a
/// selling-option dropdown (per the "updated dropdowns" mockup variant),
/// and an optional note. Remove is reached via [onRemove] (confirmed by
/// the caller with [ConfirmationDialog] before calling this).
class CartItemRow extends StatelessWidget {
  const CartItemRow({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onSellingOptionChanged,
    required this.onRemove,
  });

  final CartItemEntity item;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<String> onSellingOptionChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpace.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.image),
                child: SizedBox(
                  width: 80,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(item.meal.imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.meal.name,
                            style: textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${item.subtotal.toStringAsFixed(2)} AED',
                          style: textTheme.titleMedium?.copyWith(color: scheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpace.s),
                    Wrap(
                      spacing: AppSpace.xs,
                      runSpacing: AppSpace.xs,
                      children: item.meal.sellingOptions.map((option) {
                        final isSelected = option.id == item.sellingOption.id;
                        return GestureDetector(
                          onTap: () => onSellingOptionChanged(option.id),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpace.m,
                              vertical: AppSpace.xs,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? scheme.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                              border: Border.all(
                                color: isSelected ? scheme.primary : scheme.outline,
                              ),
                            ),
                            child: Text(
                              option.label,
                              style: textTheme.bodySmall?.copyWith(
                                color: isSelected ? scheme.onPrimary : scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(AppSpace.xs),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: scheme.outline),
                ),
                child: Row(
                  children: [
                    _StepperButton(
                      icon: Icons.remove,
                      onTap: () => onQuantityChanged(item.quantity - 1),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '${item.quantity}',
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium,
                      ),
                    ),
                    _StepperButton(
                      icon: Icons.add,
                      onTap: () => onQuantityChanged(item.quantity + 1),
                    ),
                  ],
                ),
              ),
              if (item.note != null && item.note!.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: AppSpace.m),
                    child: Row(
                      children: [
                        Icon(Icons.notes, size: 18, color: scheme.onSurfaceVariant),
                        const SizedBox(width: AppSpace.xs),
                        Expanded(
                          child: Text(
                            item.note!,
                            style: textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.delete_outline, color: scheme.error),
                tooltip: 'إزالة',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Icon(icon, size: 20, color: scheme.primary),
      ),
    );
  }
}
