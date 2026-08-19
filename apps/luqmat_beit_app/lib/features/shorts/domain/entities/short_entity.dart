import 'package:equatable/equatable.dart';

/// A single "short" in the vertical shorts feed (CU-26/27), backed by
/// `GET /user/customer/content/feed`. [videoUrl] is a real streamable video
/// (`.mp4`, supports `Range` requests) — not a still image. [mealId] is
/// null when the cook posted the short without linking it to one of their
/// meals (the backend's `meal` field is nullable), in which case there is
/// nothing for "order this meal" to navigate to.
class ShortEntity extends Equatable {
  final String id;
  final String? mealId;
  final String cookId;
  final String cookName;
  final String cookAvatarUrl;
  final String videoUrl;
  final String caption;
  final int likeCount;
  final int commentCount;
  final int viewCount;
  final bool isLiked;

  /// The feed's `is_followed` field, same shape as `is_reacted`/[isLiked].
  final bool isFollowing;

  const ShortEntity({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.cookAvatarUrl,
    required this.videoUrl,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.viewCount,
    required this.isLiked,
    this.isFollowing = false,
    this.mealId,
  });

  ShortEntity copyWith({
    int? likeCount,
    int? commentCount,
    bool? isLiked,
    bool? isFollowing,
  }) {
    return ShortEntity(
      id: id,
      mealId: mealId,
      cookId: cookId,
      cookName: cookName,
      cookAvatarUrl: cookAvatarUrl,
      videoUrl: videoUrl,
      caption: caption,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      viewCount: viewCount,
      isLiked: isLiked ?? this.isLiked,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        mealId,
        cookId,
        cookName,
        cookAvatarUrl,
        videoUrl,
        caption,
        likeCount,
        commentCount,
        viewCount,
        isLiked,
        isFollowing,
      ];
}
