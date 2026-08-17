/// The validated payload `UpdateCookProfile` consumes — built only after
/// `validateProfileForm` reports no errors.
class ProfileFormSubmission {
  const ProfileFormSubmission({
    required this.fullName,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    this.availabilityDays,
    this.latitude,
    this.longitude,
    this.avatarPath,
  });

  final String fullName;
  final String phoneNumber;
  final String bio;
  final String address;

  /// Both `"HH:mm"` 24-hour strings — combined into one `availabilityTime`
  /// window (`"$start-$end"`) by the repository, not stored separately.
  final String availabilityStartTime;
  final String availabilityEndTime;

  /// ISO weekday numbers (1=Monday…7=Sunday) from the day-range picker —
  /// null/empty is a valid "didn't change the day range" state, never
  /// required.
  final List<int>? availabilityDays;

  /// Null until the cook taps the location-detect button — never required.
  final double? latitude;
  final double? longitude;

  /// Null when the cook didn't pick a new photo — the existing
  /// `avatarUrl` is kept as-is by the repository in that case.
  final String? avatarPath;
}
