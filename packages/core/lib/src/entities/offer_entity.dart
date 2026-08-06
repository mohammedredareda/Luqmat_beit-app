import 'package:equatable/equatable.dart';

enum OfferType { buyOneGetOne, bundle, freeDelivery }

class OfferEntity extends Equatable {
  final String id;
  final String cookId;
  final OfferType type;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  const OfferEntity({
    required this.id,
    required this.cookId,
    required this.type,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  @override
  List<Object?> get props =>
      [id, cookId, type, title, description, startDate, endDate];
}
