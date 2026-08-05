import 'package:equatable/equatable.dart';

/// Minimal cook profile needed by the meal-management feature — just
/// enough to know whether the cook's whole kitchen is paused (CK-10).
class CookEntity extends Equatable {
  const CookEntity({
    required this.id,
    required this.isActive,
  });

  final String id;

  /// False when the cook has toggled Stop Selling (CK-10). Not derived —
  /// a plain field, same reasoning as [MealEntity.isActive].
  final bool isActive;

  @override
  List<Object?> get props => [id, isActive];
}
