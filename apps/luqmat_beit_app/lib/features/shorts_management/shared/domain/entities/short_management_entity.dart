import 'package:equatable/equatable.dart';

/// A short video the cook has published from the "My Shorts" gallery —
/// distinct from the customer-facing `ShortEntity` (`features/shorts/`),
/// which is a separate, still-mocked read-only feed with no create/delete
/// affordance. The real `/user/cook/content` response has no thumbnail
/// field (see `ShortsRemoteDataSource`'s doc comment), so [thumbnailUrl] is
/// always `null` today — the gallery card falls back to a placeholder
/// rather than trying to render a video frame.
class ShortManagementEntity extends Equatable {
  final String id;
  final String cookId;
  final String description;

  /// The real playable video URL (the backend's `url` field) — always
  /// present for a published short, since a video is required to publish
  /// one at all.
  final String videoUrl;
  final String? thumbnailUrl;
  final int viewCount;
  final DateTime createdAt;

  /// Denormalized linked-meal display fields (mirrors `DiscountModel`'s
  /// `mealName`/`mealImageUrl` convention) — `null` together when the short
  /// has no linked meal, since linking is optional (mockup `_3`'s toggle).
  final String? mealId;
  final String? mealName;
  final String? mealImageUrl;

  const ShortManagementEntity({
    required this.id,
    required this.cookId,
    required this.description,
    required this.videoUrl,
    required this.viewCount,
    required this.createdAt,
    this.thumbnailUrl,
    this.mealId,
    this.mealName,
    this.mealImageUrl,
  });

  bool get hasLinkedMeal => mealId != null;

  @override
  List<Object?> get props => [
        id,
        cookId,
        description,
        videoUrl,
        thumbnailUrl,
        viewCount,
        createdAt,
        mealId,
        mealName,
        mealImageUrl,
      ];
}
