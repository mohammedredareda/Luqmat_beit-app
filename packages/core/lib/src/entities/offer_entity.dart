import 'package:equatable/equatable.dart';

import 'offer_meal_entity.dart';

/// CK-11–CK-14's bundle offer — a fixed-price bundle of one-or-more meals,
/// active for a fixed number of days from creation.
class OfferEntity extends Equatable {
  const OfferEntity({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.durationDays,
    required this.isActive,
    required this.createdAt,
    this.imageUrl,
    this.includedMeals = const [],
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final double totalPrice;
  final int durationDays;
  final bool isActive;
  final DateTime createdAt;

  /// Optional cook-uploaded bundle photo (a bundle has no single
  /// representative meal, so unlike [OfferMealEntity]'s per-meal images
  /// this is never derived — the offer card falls back to a stylized
  /// placeholder when null, per the `offers_discounts` mockup).
  final String? imageUrl;

  final List<OfferMealEntity> includedMeals;

  /// Days left until `createdAt + durationDays`, floored at 0. Always
  /// derived — never persisted — so the list card's expiry chip can't
  /// go stale between loads.
  int get remainingDays {
    final expiresAt = createdAt.add(Duration(days: durationDays));
    final diff = expiresAt.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  @override
  List<Object?> get props => [
        id,
        cookId,
        name,
        description,
        totalPrice,
        durationDays,
        isActive,
        createdAt,
        imageUrl,
        includedMeals,
      ];
}
