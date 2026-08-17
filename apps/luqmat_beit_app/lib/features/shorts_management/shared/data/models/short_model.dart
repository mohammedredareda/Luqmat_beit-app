import '../../domain/entities/short_management_entity.dart';

/// [videoPath] and [deletedAt] are data-layer-only, mirroring
/// `DiscountModel`/`MealModel`'s convention — [videoPath] never reaches
/// [ShortManagementEntity] since there's no video backend to serve it back
/// from yet (see `FakeShortsRemoteDataSource`'s doc comment), and
/// [deletedAt] backs a CK-15-style soft delete. No `fromJson`/`toJson`/
/// `toApiRequestFields` here — unlike `DiscountModel`, there's no confirmed
/// API contract anywhere for Shorts to shape those around yet.
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
    this.deletedAt,
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
  final DateTime? deletedAt;

  ShortManagementEntity toEntity() => ShortManagementEntity(
        id: id,
        cookId: cookId,
        description: description,
        thumbnailUrl: thumbnailUrl,
        viewCount: viewCount,
        createdAt: createdAt,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
      );

  ShortModel copyWith({DateTime? deletedAt}) => ShortModel(
        id: id,
        cookId: cookId,
        videoPath: videoPath,
        description: description,
        viewCount: viewCount,
        createdAt: createdAt,
        thumbnailUrl: thumbnailUrl,
        mealId: mealId,
        mealName: mealName,
        mealImageUrl: mealImageUrl,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}
