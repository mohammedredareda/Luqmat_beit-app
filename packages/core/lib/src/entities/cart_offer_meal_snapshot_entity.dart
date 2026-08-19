import 'package:equatable/equatable.dart';

/// One meal inside a [CartOfferItemEntity] — the exact per-meal snapshot
/// `POST /order/confirm` requires resubmitted verbatim under
/// `offers[].meals[]` alongside the offer's own `total_price`/`expire_time`.
/// The backend re-validates every item of an order against what it has on
/// file and rejects the whole call if anything doesn't match, so this has
/// to carry the real `discount_percentage` from the cart response rather
/// than one recomputed client-side.
class CartOfferMealSnapshotEntity extends Equatable {
  final String mealId;
  final String name;
  final String imageUrl;
  final String variationQuantity;
  final double price;
  final double? discountPercentage;
  final double finalPrice;

  const CartOfferMealSnapshotEntity({
    required this.mealId,
    required this.name,
    required this.imageUrl,
    required this.variationQuantity,
    required this.price,
    this.discountPercentage,
    required this.finalPrice,
  });

  @override
  List<Object?> get props => [
        mealId,
        name,
        imageUrl,
        variationQuantity,
        price,
        discountPercentage,
        finalPrice,
      ];
}
