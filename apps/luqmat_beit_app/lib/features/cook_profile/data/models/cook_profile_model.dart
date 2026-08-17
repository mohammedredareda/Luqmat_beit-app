import 'package:core/core.dart';

import '../../domain/cook_profile_details.dart';

/// `availabilityTime` is stored as `"HH:mm-HH:mm"` (a single window, not a
/// per-weekday schedule — see CK-20/CU-11 in the updated backlog).
class CookProfileModel {
  const CookProfileModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.availabilityTime,
    required this.rating,
    required this.reviewCount,
    this.avatarUrl,
    this.availabilityDays = const [],
    this.latitude,
    this.longitude,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final String? avatarUrl;
  final String bio;
  final String address;
  final String availabilityTime;
  final double rating;
  final int reviewCount;

  /// `PATCH`/`GET /users/profile`'s own confirmed numbering —
  /// 1=Sunday…7=Saturday (not ISO-8601) — empty means "not set".
  final List<int> availabilityDays;
  final double? latitude;
  final double? longitude;

  factory CookProfileModel.fromJson(Map<String, dynamic> json) => CookProfileModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        bio: json['bio'] as String,
        address: json['address'] as String,
        availabilityTime: json['availabilityTime'] as String,
        rating: (json['rating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        availabilityDays: (json['availabilityDays'] as List<dynamic>? ?? const [])
            .map((e) => e as int)
            .toList(),
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
      );

  /// Real-shape response parsing from `GET /users/profile` — response is
  /// `{"user": {...}}` (pass `json['user']` in), a richer/differently-named
  /// shape than [fromJson]'s local-persistence shape: `name`/`phone`/
  /// `image`/`cook_description` (not `fullName`/`phoneNumber`/`avatarUrl`/
  /// `bio`), `startAvailabilityTime`/`endAvailabilityTime` as full ISO
  /// datetimes (combined here into one `"HH:mm-HH:mm"` string, matching
  /// this app's internal convention), `availability_days` in this endpoint
  /// family's confirmed 1=Sunday…7=Saturday numbering, and `rate` — no
  /// review-count field at all, defaults to 0.
  factory CookProfileModel.fromApiUserJson(Map<String, dynamic> json) {
    final start = DateTime.tryParse(json['startAvailabilityTime']?.toString() ?? '');
    final end = DateTime.tryParse(json['endAvailabilityTime']?.toString() ?? '');
    final availabilityTime =
        start != null && end != null ? '${_hhmm(start)}-${_hhmm(end)}' : '09:00-17:00';

    return CookProfileModel(
      id: json['id'].toString(),
      fullName: json['name'] as String? ?? '',
      phoneNumber: json['phone'] as String? ?? '',
      avatarUrl: json['image'] as String?,
      bio: json['cook_description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      availabilityTime: availabilityTime,
      rating: (json['rate'] as num?)?.toDouble() ?? 0,
      reviewCount: 0,
      availabilityDays: (json['availability_days'] as List<dynamic>? ?? const [])
          .map((e) => e as int)
          .toList(),
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
    );
  }

  static String _hhmm(DateTime dateTime) {
    final utc = dateTime.toUtc();
    return '${utc.hour.toString().padLeft(2, '0')}:${utc.minute.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'avatarUrl': avatarUrl,
        'bio': bio,
        'address': address,
        'availabilityTime': availabilityTime,
        'rating': rating,
        'reviewCount': reviewCount,
        'availabilityDays': availabilityDays,
        'latitude': latitude,
        'longitude': longitude,
      };

  CookProfileDetails toDetails() => CookProfileDetails(
        profile: CookProfileEntity(
          id: id,
          name: fullName,
          description: bio,
          photoUrl: avatarUrl,
          availabilityTime: availabilityTime,
          rate: rating,
          ratingCount: reviewCount,
        ),
        phoneNumber: phoneNumber,
        address: address,
        latitude: latitude,
        longitude: longitude,
        availabilityDays: availabilityDays,
      );

  CookProfileModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    bool clearAvatarUrl = false,
    String? bio,
    String? address,
    String? availabilityTime,
    List<int>? availabilityDays,
    double? latitude,
    double? longitude,
  }) =>
      CookProfileModel(
        id: id,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
        bio: bio ?? this.bio,
        address: address ?? this.address,
        availabilityTime: availabilityTime ?? this.availabilityTime,
        availabilityDays: availabilityDays ?? this.availabilityDays,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        rating: rating,
        reviewCount: reviewCount,
      );
}
