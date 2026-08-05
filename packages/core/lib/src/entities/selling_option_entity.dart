import 'package:equatable/equatable.dart';

/// A single sellable size/price variation of a meal (CK-07's "per-option
/// pricing"). [label] is free text (e.g. "صغير"/"كبير"), not an enum — the
/// mockup lets cooks name variations however they like.
class SellingOptionEntity extends Equatable {
  const SellingOptionEntity({
    required this.id,
    required this.label,
    required this.price,
  });

  final String id;
  final String label;
  final double price;

  @override
  List<Object?> get props => [id, label, price];
}
