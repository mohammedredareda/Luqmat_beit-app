import 'package:equatable/equatable.dart';

/// One `ORDER_OFFER_ITEM` row — a bundled offer on an order, shown as a
/// single line item and never exploded into its constituent meals (CK-17).
class OrderOfferItemEntity extends Equatable {
  const OrderOfferItemEntity({
    required this.offerId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
    this.note,
  });

  final String offerId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double priceAtPurchase;
  final String? note;

  @override
  List<Object?> get props => [offerId, name, imageUrl, quantity, priceAtPurchase, note];
}
