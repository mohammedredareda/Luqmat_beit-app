import 'package:core/core.dart';

/// One displayable order line — flattens [OrderEntity.mealItems],
/// [OrderEntity.offerItems], and [OrderEntity.returnedMealItems] into a
/// single list for the item-list widgets both `view_orders` and
/// `order_details` render. A bundled offer is always one [OrderLineItem]
/// here, never exploded into its constituent meals (CK-17).
class OrderLineItem {
  const OrderLineItem({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
    this.isReturned = false,
    this.selectedOptionLabel,
  });

  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;
  final bool isReturned;

  /// The chosen selling-option variation (e.g. a size label), only ever
  /// populated for regular meal items — bundled offers and returned meals
  /// have no per-item variation of their own.
  final String? selectedOptionLabel;
}

List<OrderLineItem> flattenOrderLineItems(OrderEntity order) => [
      for (final item in order.mealItems)
        OrderLineItem(
          name: item.name,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
          priceAtPurchase: item.priceAtPurchase,
          note: item.note,
          selectedOptionLabel: item.selectedOptionLabel,
        ),
      for (final item in order.offerItems)
        OrderLineItem(
          name: item.name,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
          priceAtPurchase: item.priceAtPurchase,
          note: item.note,
        ),
      for (final item in order.returnedMealItems)
        OrderLineItem(
          name: item.name,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
          priceAtPurchase: item.priceAtPurchase,
          note: item.note,
          isReturned: true,
        ),
    ];
