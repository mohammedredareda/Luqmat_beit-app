import 'package:equatable/equatable.dart';

/// One `CART_OFFER_ITEM` row.
class CartOfferItemEntity extends Equatable {
  final String id;
  final String offerId;
  final String offerName;
  final String? offerImageUrl;
  final double unitPrice;
  final int quantity;

  const CartOfferItemEntity({
    required this.id,
    required this.offerId,
    required this.offerName,
    required this.unitPrice,
    required this.quantity,
    this.offerImageUrl,
  });

  double get subtotal => unitPrice * quantity;

  CartOfferItemEntity copyWith({int? quantity}) => CartOfferItemEntity(
        id: id,
        offerId: offerId,
        offerName: offerName,
        offerImageUrl: offerImageUrl,
        unitPrice: unitPrice,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object?> get props =>
      [id, offerId, offerName, offerImageUrl, unitPrice, quantity];
}
