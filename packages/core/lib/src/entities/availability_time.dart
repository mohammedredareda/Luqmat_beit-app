import 'package:equatable/equatable.dart';

/// A plain time-of-day value (0-23 hour, 0-59 minute), deliberately not
/// Flutter's `TimeOfDay` — entities in `core` stay Flutter-free. The
/// presentation layer converts to/from `TimeOfDay` at the UI boundary
/// (`showTimePicker`) and is responsible for locale-correct, R-15-compliant
/// (Latin numerals) formatting.
class AvailabilityTime extends Equatable implements Comparable<AvailabilityTime> {
  const AvailabilityTime({required this.hour, required this.minute});

  final int hour;
  final int minute;

  int get totalMinutes => hour * 60 + minute;

  @override
  int compareTo(AvailabilityTime other) => totalMinutes.compareTo(other.totalMinutes);

  @override
  List<Object?> get props => [hour, minute];
}
