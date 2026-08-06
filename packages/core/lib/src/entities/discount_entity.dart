import 'package:equatable/equatable.dart';

enum DiscountType { percentage, fixedAmount }

class DiscountEntity extends Equatable {
  final String id;
  final String mealId;
  final DiscountType type;
  final double value;
  final DateTime startDate;
  final DateTime endDate;

  const DiscountEntity({
    required this.id,
    required this.mealId,
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  double apply(double price) => switch (type) {
        DiscountType.percentage => price - (price * value / 100),
        DiscountType.fixedAmount => (price - value).clamp(0, price),
      };

  @override
  List<Object?> get props => [id, mealId, type, value, startDate, endDate];
}
