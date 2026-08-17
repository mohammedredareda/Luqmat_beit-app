import 'package:core/core.dart';

/// Wraps the shared [CookProfileEntity] with `cook_app`-local fields
/// (`phoneNumber`, `address`) that are legitimate confirmed `USER`/`COOK`
/// data this app displays/edits, but aren't part of the cross-app shared
/// entity shape (only `cook_app` edits its own phone number/address today).
class CookProfileDetails {
  const CookProfileDetails({
    required this.profile,
    required this.phoneNumber,
    required this.address,
    this.latitude,
    this.longitude,
    this.availabilityDays = const [],
  });

  final CookProfileEntity profile;
  final String phoneNumber;
  final String address;

  /// Null until the cook has ever set a location (via `PATCH
  /// /users/profile` or the location-detect button).
  final double? latitude;
  final double? longitude;

  /// `PATCH`/`GET /users/profile`'s own confirmed numbering —
  /// 1=Sunday…7=Saturday (not ISO-8601).
  final List<int> availabilityDays;

  CookProfileDetails copyWith({
    CookProfileEntity? profile,
    String? phoneNumber,
    String? address,
    double? latitude,
    double? longitude,
    List<int>? availabilityDays,
  }) =>
      CookProfileDetails(
        profile: profile ?? this.profile,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        availabilityDays: availabilityDays ?? this.availabilityDays,
      );
}
