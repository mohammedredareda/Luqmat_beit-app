import 'package:core/core.dart';

class CookProfileModel {
  const CookProfileModel({
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
  final Set<Weekday> availabilityDays;
  final AvailabilityTime availabilityStartTime;
  final AvailabilityTime availabilityEndTime;
  final double rating;
  final int reviewCount;
  final int completedOrdersCount;
  final int totalMealsCount;

  factory CookProfileModel.fromJson(Map<String, dynamic> json) => CookProfileModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        bio: json['bio'] as String,
        address: json['address'] as String,
        availabilityDays: (json['availabilityDays'] as List<dynamic>)
            .map((id) => Weekday.fromId(id as String))
            .whereType<Weekday>()
            .toSet(),
        availabilityStartTime: AvailabilityTime(
          hour: json['availabilityStartHour'] as int,
          minute: json['availabilityStartMinute'] as int,
        ),
        availabilityEndTime: AvailabilityTime(
          hour: json['availabilityEndHour'] as int,
          minute: json['availabilityEndMinute'] as int,
        ),
        rating: (json['rating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        completedOrdersCount: json['completedOrdersCount'] as int,
        totalMealsCount: json['totalMealsCount'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'avatarUrl': avatarUrl,
        'bio': bio,
        'address': address,
        'availabilityDays': availabilityDays.map((d) => d.id).toList(),
        'availabilityStartHour': availabilityStartTime.hour,
        'availabilityStartMinute': availabilityStartTime.minute,
        'availabilityEndHour': availabilityEndTime.hour,
        'availabilityEndMinute': availabilityEndTime.minute,
        'rating': rating,
        'reviewCount': reviewCount,
        'completedOrdersCount': completedOrdersCount,
        'totalMealsCount': totalMealsCount,
      };

  CookProfileEntity toEntity() => CookProfileEntity(
        id: id,
        fullName: fullName,
        phoneNumber: phoneNumber,
        avatarUrl: avatarUrl,
        bio: bio,
        address: address,
        availabilityDays: availabilityDays,
        availabilityStartTime: availabilityStartTime,
        availabilityEndTime: availabilityEndTime,
        rating: rating,
        reviewCount: reviewCount,
        completedOrdersCount: completedOrdersCount,
        totalMealsCount: totalMealsCount,
      );

  CookProfileModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    bool clearAvatarUrl = false,
    String? bio,
    String? address,
    Set<Weekday>? availabilityDays,
    AvailabilityTime? availabilityStartTime,
    AvailabilityTime? availabilityEndTime,
  }) =>
      CookProfileModel(
        id: id,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
        bio: bio ?? this.bio,
        address: address ?? this.address,
        availabilityDays: availabilityDays ?? this.availabilityDays,
        availabilityStartTime: availabilityStartTime ?? this.availabilityStartTime,
        availabilityEndTime: availabilityEndTime ?? this.availabilityEndTime,
        rating: rating,
        reviewCount: reviewCount,
        completedOrdersCount: completedOrdersCount,
        totalMealsCount: totalMealsCount,
      );
}
