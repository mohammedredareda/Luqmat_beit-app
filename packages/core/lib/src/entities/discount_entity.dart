import 'package:equatable/equatable.dart';

enum DiscountStatus { active, deleted }

/// A `Discount` always targets exactly one meal — there is no "applies to
/// whole menu" restriction-mode concept in the backlog.
class DiscountEntity extends Equatable {
  final String id;
  final String mealId;
  final double discountPercentage;
  final int discountDurationDays;
  final int? usageNumberLimit;
  final DateTime createdAt;
  final DateTime expiryTime;
  final int usageCount;
  final DiscountStatus status;

  const DiscountEntity({
    required this.id,
    required this.mealId,
    required this.discountPercentage,
    required this.discountDurationDays,
    required this.createdAt,
    required this.expiryTime,
    this.usageNumberLimit,
    this.usageCount = 0,
    this.status = DiscountStatus.active,
  });

  bool get isActive =>
      status == DiscountStatus.active &&
      DateTime.now().isBefore(expiryTime) &&
      (usageNumberLimit == null || usageCount < usageNumberLimit!);

  double apply(double price) => price - (price * discountPercentage / 100);

  @override
  List<Object?> get props => [
        id,
        mealId,
        discountPercentage,
        discountDurationDays,
        usageNumberLimit,
        createdAt,
        expiryTime,
        usageCount,
        status,
      ];
}
