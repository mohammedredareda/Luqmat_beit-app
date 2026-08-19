import 'package:equatable/equatable.dart';

import 'cart_offer_meal_snapshot_entity.dart';

/// One `CART_OFFER_ITEM` row. [expireTime] and [meals] aren't shown
/// anywhere in the cart UI — they're carried purely so `POST
/// /order/confirm` can resubmit this offer's exact snapshot (see
/// [CartOfferMealSnapshotEntity]).
class CartOfferItemEntity extends Equatable {
  final String id;
  final String offerId;
  final String offerName;
  final String? offerImageUrl;
  final double unitPrice;
  final int quantity;
  final DateTime expireTime;
  final List<CartOfferMealSnapshotEntity> meals;

  const CartOfferItemEntity({
    required this.id,
    required this.offerId,
    required this.offerName,
    required this.unitPrice,
    required this.quantity,
    required this.expireTime,
    this.offerImageUrl,
    this.meals = const [],
  });

  double get subtotal => unitPrice * quantity;

  CartOfferItemEntity copyWith({int? quantity}) => CartOfferItemEntity(
        id: id,
        offerId: offerId,
        offerName: offerName,
        offerImageUrl: offerImageUrl,
        unitPrice: unitPrice,
        quantity: quantity ?? this.quantity,
        expireTime: expireTime,
        meals: meals,
      );

  @override
  List<Object?> get props => [
        id,
        offerId,
        offerName,
        offerImageUrl,
        unitPrice,
        quantity,
        expireTime,
        meals
      ];
}
