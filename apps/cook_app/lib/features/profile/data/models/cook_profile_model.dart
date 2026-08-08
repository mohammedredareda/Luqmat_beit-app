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
      );

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
      );

  CookProfileModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    bool clearAvatarUrl = false,
    String? bio,
    String? address,
    String? availabilityTime,
  }) =>
      CookProfileModel(
        id: id,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
        bio: bio ?? this.bio,
        address: address ?? this.address,
        availabilityTime: availabilityTime ?? this.availabilityTime,
        rating: rating,
        reviewCount: reviewCount,
      );
}
