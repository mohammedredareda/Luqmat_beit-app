import 'package:equatable/equatable.dart';

/// One `ORDER_OFFER_ITEM` line — an ordered offer bundle is shown as a
/// single line item, never exploded into its individual meals.
/// `priceAtPurchase` snapshots the offer's `totalPrice` at order time.
class OrderOfferItemEntity extends Equatable {
  final String id;
  final String offerId;
  final String offerName;
  final List<String> mealNames;
  final double priceAtPurchase;
  final int quantity;

  const OrderOfferItemEntity({
    required this.id,
    required this.offerId,
    required this.offerName,
    required this.priceAtPurchase,
    required this.quantity,
    this.mealNames = const [],
  });

  double get subtotal => priceAtPurchase * quantity;

  @override
  List<Object?> get props =>
      [id, offerId, offerName, mealNames, priceAtPurchase, quantity];
}
