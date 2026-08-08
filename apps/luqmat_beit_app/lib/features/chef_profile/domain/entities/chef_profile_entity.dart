import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

/// Everything the Chef Profile screen (CU-11) renders in one fetch: chef
/// info, follow state, and the chef's own meal list — hence a single
/// entity rather than composing the Home feature's `ChefSummaryEntity`.
class ChefProfileEntity extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final String bio;
  final double rating;
  final int ratingCount;
  final double distanceKm;
  final bool isFollowing;
  final List<MealEntity> meals;

  const ChefProfileEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.rating,
    required this.ratingCount,
    required this.distanceKm,
    required this.isFollowing,
    required this.meals,
  });

  ChefProfileEntity copyWith({bool? isFollowing}) {
    return ChefProfileEntity(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      bio: bio,
      rating: rating,
      ratingCount: ratingCount,
      distanceKm: distanceKm,
      isFollowing: isFollowing ?? this.isFollowing,
      meals: meals,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUrl,
        bio,
        rating,
        ratingCount,
        distanceKm,
        isFollowing,
        meals,
      ];
}
