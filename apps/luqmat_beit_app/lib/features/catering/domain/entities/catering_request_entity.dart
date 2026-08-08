import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

/// A draft/submitted bulk (catering) order — CU-25. Reuses
/// [CartMealItemEntity] for line items since a catering request is
/// structurally a large-quantity cart: same meal + selling option +
/// quantity shape, just headed for human review instead of the normal
/// checkout flow.
class CateringRequestEntity extends Equatable {
  const CateringRequestEntity({
    required this.id,
    required this.items,
    required this.guestCount,
    required this.eventDate,
    required this.deliveryAddress,
    required this.totalEstimate,
    this.specialInstructions,
  });

  final String id;
  final List<CartMealItemEntity> items;
  final int guestCount;
  final DateTime eventDate;
  final String deliveryAddress;
  final String? specialInstructions;
  final double totalEstimate;

  @override
  List<Object?> get props => [
        id,
        items,
        guestCount,
        eventDate,
        deliveryAddress,
        specialInstructions,
        totalEstimate,
      ];
}
