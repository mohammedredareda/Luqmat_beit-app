import 'package:equatable/equatable.dart';

/// A cook's profile — shared by `cook_app` (editing, CK-20/21) and
/// `customer_app`'s chef-profile screen (viewing, CU-11). `availabilityTime`
/// is deliberately a single time-window value, not a per-weekday schedule —
/// the backlog does not describe a weekly-availability structure anywhere.
class CookProfileEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? photoUrl;
  final String availabilityTime;
  final bool isSellingPaused;
  final double rate;
  final int ratingCount;

  const CookProfileEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.availabilityTime,
    this.photoUrl,
    this.isSellingPaused = false,
    this.rate = 0,
    this.ratingCount = 0,
  });

  /// CU-11's "Available Now" / "Offline" derivation — factors in only
  /// [isSellingPaused]; the caller supplies whether the current time falls
  /// within [availabilityTime].
  bool computeIsAvailableNow({required bool withinAvailabilityWindow}) =>
      withinAvailabilityWindow && !isSellingPaused;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        photoUrl,
        availabilityTime,
        isSellingPaused,
        rate,
        ratingCount,
      ];
}
