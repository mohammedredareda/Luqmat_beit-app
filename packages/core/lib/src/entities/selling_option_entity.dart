import 'package:equatable/equatable.dart';

/// A meal can be sold "per plate" or "per weight/kg" — the exact selling
/// option a cook chose for that meal.
class SellingOptionEntity extends Equatable {
  final String id;
  final String label;
  final double price;
  final String? unit;

  const SellingOptionEntity({
    required this.id,
    required this.label,
    required this.price,
    this.unit,
  });

  @override
  List<Object?> get props => [id, label, price, unit];
}
