import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

/// CK-11's offers+discounts grid renders both as one interleaved feed
/// (per the `offers_discounts` mockup) even though they're two separate
/// backend tables ([OfferEntity], [DiscountEntity]) — this union is the
/// merge point, local to this one screen rather than a shared core
/// concept, so it's a display-feed construct, not a domain entity.
sealed class OfferFeedItemEntity extends Equatable {
  const OfferFeedItemEntity();

  /// Namespaced so an offer and a discount can never collide as a cursor,
  /// even though each entity's own `id` is only unique within its table.
  String get id;

  DateTime get createdAt;
}

class OfferFeedOfferItem extends OfferFeedItemEntity {
  const OfferFeedOfferItem(this.offer);

  final OfferEntity offer;

  @override
  String get id => 'offer:${offer.id}';

  @override
  DateTime get createdAt => offer.createdAt;

  @override
  List<Object?> get props => [offer];
}

class OfferFeedDiscountItem extends OfferFeedItemEntity {
  const OfferFeedDiscountItem(this.discount);

  final DiscountEntity discount;

  @override
  String get id => 'discount:${discount.id}';

  @override
  DateTime get createdAt => discount.createdAt;

  @override
  List<Object?> get props => [discount];
}
