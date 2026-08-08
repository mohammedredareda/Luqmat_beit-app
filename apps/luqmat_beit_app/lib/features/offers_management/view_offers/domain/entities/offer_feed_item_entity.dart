import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

/// CK-11's offers+discounts grid renders both as one interleaved feed
/// (per the `offers_discounts` mockup) even though they're two separate
/// backend tables ([OfferEntity], [DiscountEntity]) — this union is the
/// merge point, local to this one screen rather than a shared core
/// concept, so it's a display-feed construct, not a domain entity. It also
/// carries the denormalized meal/image display fields that only exist on
/// the data-layer models, since the shared entities were trimmed to their
/// backlog-confirmed fields only.
sealed class OfferFeedItemEntity extends Equatable {
  const OfferFeedItemEntity();

  /// Namespaced so an offer and a discount can never collide as a cursor,
  /// even though each entity's own `id` is only unique within its table.
  String get id;

  DateTime get createdAt;
}

class OfferFeedOfferItem extends OfferFeedItemEntity {
  const OfferFeedOfferItem(this.offer, {this.imageUrl});

  final OfferEntity offer;
  final String? imageUrl;

  @override
  String get id => 'offer:${offer.id}';

  @override
  DateTime get createdAt => offer.createdAt;

  @override
  List<Object?> get props => [offer, imageUrl];
}

class OfferFeedDiscountItem extends OfferFeedItemEntity {
  const OfferFeedDiscountItem(
    this.discount, {
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
  });

  final DiscountEntity discount;
  final String mealName;
  final String mealImageUrl;
  final double mealBasePrice;

  @override
  String get id => 'discount:${discount.id}';

  @override
  DateTime get createdAt => discount.createdAt;

  @override
  List<Object?> get props => [discount, mealName, mealImageUrl, mealBasePrice];
}
