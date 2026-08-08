import 'package:equatable/equatable.dart';

import 'offer_meal_entity.dart';

enum OfferStatus { active, deleted }

/// An `Offer` bundles multiple meals at one flat `totalPrice`, independent
/// of the sum of the individual meals' prices.
class OfferEntity extends Equatable {
  final String id;
  final String cookId;
  final String name;
  final String description;
  final int durationDays;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime expiryTime;
  final OfferStatus status;
  final List<OfferMealEntity> meals;

  const OfferEntity({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.durationDays,
    required this.totalPrice,
    required this.createdAt,
    required this.expiryTime,
    this.status = OfferStatus.active,
    this.meals = const [],
  });

  bool get isActive =>
      status == OfferStatus.active && DateTime.now().isBefore(expiryTime);

  @override
  List<Object?> get props => [
        id,
        cookId,
        name,
        description,
        durationDays,
        totalPrice,
        createdAt,
        expiryTime,
        status,
        meals,
      ];
}
