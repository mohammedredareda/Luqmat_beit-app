import '../../domain/entities/short_management_entity.dart';

/// [videoPath] holds a local file path before upload, and becomes the real
/// remote video URL once [ShortsRemoteDataSource.createShort] round-trips
/// it — mirrors `MealModel.imageUrl`'s same local-path-then-remote-URL
/// lifecycle.
class ShortModel {
  const ShortModel({
    required this.id,
    required this.cookId,
    required this.videoPath,
    required this.description,
    required this.viewCount,
    required this.createdAt,
    this.thumbnailUrl,
    this.mealId,
    this.mealName,
    this.mealImageUrl,
  });

  final String id;
  final String cookId;
  final String videoPath;
  final String description;
  final int viewCount;
  final DateTime createdAt;
  final String? thumbnailUrl;
  final String? mealId;
  final String? mealName;
  final String? mealImageUrl;

  /// Parses `POST/PATCH /user/cook/content`'s `data` object (confirmed via
  /// Postman: https://documenter.getpostman.com/view/38865108/2sBY4TpJ1v —
  /// Cook > Content). `id`/`cookId`/`mealId` arrive numeric; converted to
  /// String to match every other id in this app's models (mirrors
  /// `DiscountModel.fromApiJson`'s same `.toString()` convention). No
  /// `mealName`/`mealImageUrl` in the response — those are denormalized
  /// display fields the caller must carry over itself.
  factory ShortModel.fromApiJson(Map<String, dynamic> json) => ShortModel(
        id: json['id'].toString(),
        cookId: json['cookId'].toString(),
        videoPath: json['url'] as String? ?? '',
        description: json['description'] as String? ?? '',
        viewCount: (json['viewsCount'] as num?)?.toInt() ?? 0,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
        mealId: json['mealId']?.toString(),
      );

  /// Parses one item of `GET /user/cook/content`'s `data` array (confirmed
  /// via Postman — Cook > Content > "Get My content"). This endpoint
  /// returns a **different, snake_case shape** than Upload/Edit's `data`
  /// object (`content_id`/`created_at`/`views_count`, a nested
  /// `meal: {meal_id, name}` instead of a flat `mealId`) — not a copy-paste
  /// inconsistency to paper over, the backend genuinely shapes list items
  /// differently, so this is a deliberately separate factory from
  /// [fromApiJson] rather than one method juggling both key sets. There's
  /// no `cookId` on a list item either (the endpoint is inherently
  /// "my content"), so it's supplied by the caller instead. `reacts_count`/
  /// `comments_count` are also present on each item but unparsed — nothing
  /// in this feature displays them yet; they're available here if a future
  /// screen needs them.
  factory ShortModel.fromListItemJson(Map<String, dynamic> json, {required String cookId}) {
    final meal = json['meal'] as Map?;
    return ShortModel(
      id: json['content_id'].toString(),
      cookId: cookId,
      videoPath: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      viewCount: (json['views_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      mealId: meal?['meal_id']?.toString(),
      mealName: meal?['name'] as String?,
    );
  }

  /// `description`/`meal_id` for the real endpoint — `video` is handled
  /// separately as a `MultipartFile`, not part of this map (mirrors
  /// `MealModel`'s split between `toApiRequestFields()` and the image
  /// multipart field `MealRemoteDataSource._multipartFields` adds).
  Map<String, dynamic> toApiRequestFields() => {
        'description': description,
        if (mealId != null) 'meal_id': int.tryParse(mealId!) ?? mealId,
      };

  ShortManagementEntity toEntity() => ShortManagementEntity(
        id: id,
        cookId: cookId,
        description: description,
        videoUrl: videoPath,
        thumbnailUrl: thumbnailUrl,
        viewCount: viewCount,
        createdAt: createdAt,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
      );

  /// Only for carrying the denormalized meal display fields across a
  /// create response, which has no `mealName`/`mealImageUrl` of its own
  /// (mirrors `DiscountsRemoteDataSource.updateDiscount`'s identical
  /// copyWith after its own field-poor PUT response).
  ShortModel copyWith({String? mealName, String? mealImageUrl}) => ShortModel(
        id: id,
        cookId: cookId,
        videoPath: videoPath,
        description: description,
        viewCount: viewCount,
        createdAt: createdAt,
        thumbnailUrl: thumbnailUrl,
        mealId: mealId,
        mealName: mealName ?? this.mealName,
        mealImageUrl: mealImageUrl ?? this.mealImageUrl,
      );
}
