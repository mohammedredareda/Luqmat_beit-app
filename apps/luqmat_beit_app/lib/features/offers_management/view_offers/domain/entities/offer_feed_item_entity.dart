import 'package:equatable/equatable.dart';

/// CK-11's offers+discounts grid renders both as one interleaved feed. The
/// real backend only exposes this merged view through one endpoint
/// (`GET /user/cook/menu/promotions/my-promotions`), returning a pre-rendered
/// `title`/`description` pair per item (e.g. a discount's title already
/// reads "خصم 16.12% على شاورما دجاج" — the percentage is baked into the
/// text, not a separate field) plus an [image] URL — but still no separate
/// meal/price detail. This entity mirrors that shape rather than wrapping
/// the full `OfferEntity`/`DiscountEntity` (which this feed can't populate —
/// TODO(backend): if a per-item detail endpoint is ever added, restore the
/// richer card by hydrating from it instead of degrading here).
///
/// A discount is limited either by time ([expiryTime]) or by a usage count
/// (`usageRemaining` on [OfferFeedDiscountItem]), never necessarily both —
/// confirmed live, a usage-limited discount has a `null` [expiryTime].
sealed class OfferFeedItemEntity extends Equatable {
  const OfferFeedItemEntity();

  /// The real item id (offer id or discount id) — used to build edit/delete
  /// routes.
  String get rawId;

  String get title;
  String get description;
  DateTime get createdAt;

  /// `null` when the item has no time limit (e.g. a usage-limited discount).
  DateTime? get expiryTime;

  String? get image;

  /// Namespaced so an offer and a discount can never collide as a
  /// pagination cursor, even though [rawId] is only unique within its own
  /// table.
  String get id;

  bool get isExpired => expiryTime != null && !DateTime.now().isBefore(expiryTime!);
}

class OfferFeedOfferItem extends OfferFeedItemEntity {
  const OfferFeedOfferItem({
    required this.rawId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.expiryTime,
    this.image,
  });

  @override
  final String rawId;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiryTime;
  @override
  final String? image;

  @override
  String get id => 'offer:$rawId';

  @override
  List<Object?> get props => [rawId, title, description, createdAt, expiryTime, image];
}

class OfferFeedDiscountItem extends OfferFeedItemEntity {
  const OfferFeedDiscountItem({
    required this.rawId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.expiryTime,
    this.image,
    this.usageRemaining,
  });

  @override
  final String rawId;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiryTime;
  @override
  final String? image;

  /// Uses left before this discount stops applying — the alternative limit
  /// to [expiryTime] (see class doc comment). `null` when this discount is
  /// time-limited instead.
  final int? usageRemaining;

  @override
  String get id => 'discount:$rawId';

  @override
  List<Object?> get props =>
      [rawId, title, description, createdAt, expiryTime, image, usageRemaining];
}
