import 'package:equatable/equatable.dart';

import 'availability_time.dart';
import 'weekday.dart';

/// A cook's full public-facing profile (CK-20 Edit Profile, CK-21 View
/// Profile with Stats) — richer than [CookEntity], which stays scoped to
/// just `id`/`isActive` for meal-management's stop-selling checks. Lives in
/// `core` (not `cook_app`) since the customer app will eventually need the
/// same shape to display a chef's public profile when browsing cooks.
class CookProfileEntity extends Equatable {
  const CookProfileEntity({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.availabilityDays,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    required this.rating,
    required this.reviewCount,
    required this.completedOrdersCount,
    required this.totalMealsCount,
    this.avatarUrl,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final String? avatarUrl;
  final String bio;
  final String address;

  /// Days the cook accepts orders. A plain set — no "is this a contiguous
  /// range" inference; presentation renders one pill per selected day.
  final Set<Weekday> availabilityDays;

  final AvailabilityTime availabilityStartTime;
  final AvailabilityTime availabilityEndTime;

  /// CK-21's stats are static mock values from the fake datasource, not
  /// derived from a real orders/reviews feature (neither exists yet) —
  /// CK-21 is explicitly marked incomplete in the backlog.
  final double rating;
  final int reviewCount;
  final int completedOrdersCount;
  final int totalMealsCount;

  @override
  List<Object?> get props => [
        id,
        fullName,
        phoneNumber,
        avatarUrl,
        bio,
        address,
        availabilityDays,
        availabilityStartTime,
        availabilityEndTime,
        rating,
        reviewCount,
        completedOrdersCount,
        totalMealsCount,
      ];
}
