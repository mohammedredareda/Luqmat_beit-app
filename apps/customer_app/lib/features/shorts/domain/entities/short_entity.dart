import 'package:equatable/equatable.dart';

/// A single "short" in the vertical shorts feed (CU-26/27). There is no
/// video backend yet, so `thumbnailUrl` stands in as a full-bleed still
/// "video frame" — see `ShortsMockDataSource` for the seam a real
/// `shorts_remote_data_source.dart` would replace.
class ShortEntity extends Equatable {
  final String id;
  final String mealId;
  final String cookName;
  final String cookAvatarUrl;
  final String thumbnailUrl;
  final String caption;
  final int likeCount;
  final int commentCount;
  final bool isLiked;

  const ShortEntity({
    required this.id,
    required this.mealId,
    required this.cookName,
    required this.cookAvatarUrl,
    required this.thumbnailUrl,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  ShortEntity copyWith({
    int? likeCount,
    bool? isLiked,
  }) {
    return ShortEntity(
      id: id,
      mealId: mealId,
      cookName: cookName,
      cookAvatarUrl: cookAvatarUrl,
      thumbnailUrl: thumbnailUrl,
      caption: caption,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        mealId,
        cookName,
        cookAvatarUrl,
        thumbnailUrl,
        caption,
        likeCount,
        commentCount,
        isLiked,
      ];
}
