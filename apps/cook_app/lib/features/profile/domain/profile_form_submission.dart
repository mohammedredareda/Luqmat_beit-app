import 'package:core/core.dart';

/// The validated payload `UpdateCookProfile` consumes — built only after
/// `validateProfileForm` reports no errors.
class ProfileFormSubmission {
  const ProfileFormSubmission({
    required this.fullName,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.availabilityDays,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    this.avatarPath,
  });

  final String fullName;
  final String phoneNumber;
  final String bio;
  final String address;
  final Set<Weekday> availabilityDays;
  final AvailabilityTime availabilityStartTime;
  final AvailabilityTime availabilityEndTime;

  /// Null when the cook didn't pick a new photo — the existing
  /// `avatarUrl` is kept as-is by the repository in that case.
  final String? avatarPath;
}
