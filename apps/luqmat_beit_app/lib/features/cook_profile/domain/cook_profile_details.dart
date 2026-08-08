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
  });

  final CookProfileEntity profile;
  final String phoneNumber;
  final String address;

  CookProfileDetails copyWith({
    CookProfileEntity? profile,
    String? phoneNumber,
    String? address,
  }) =>
      CookProfileDetails(
        profile: profile ?? this.profile,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
      );
}
