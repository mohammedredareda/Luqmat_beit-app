import 'package:core/core.dart';
import 'package:dio/dio.dart' show MultipartFile;

import '../models/short_model.dart';

/// Real Dio-backed data source for the cook-side Shorts ("Content")
/// endpoints, confirmed via Postman
/// (https://documenter.getpostman.com/view/38865108/2sBY4TpJ1v — Cook >
/// Content) — replaces `FakeShortsRemoteDataSource`.
///
/// A `PATCH /user/cook/content/{id}` (edit) endpoint is also documented
/// (`{description, meal_id}`) but isn't wired here — there's still no Edit
/// Short screen/mockup; this is the seam for one later.
class ShortsRemoteDataSource {
  ShortsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  /// `GET /user/cook/content?page=N` — cursor is a page-number string, the
  /// same stand-in `MealRemoteDataSource.getMyMeals` uses until a real
  /// opaque cursor exists. List items arrive in a different, snake_case
  /// shape than Upload/Edit's `data` object — see
  /// `ShortModel.fromListItemJson`'s doc comment.
  Future<PaginatedResult<ShortModel>> getMyShorts(
    String cookId, {
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    final page = cursor == null ? 1 : int.parse(cursor);
    final response = await _apiClient.get(
      '/user/cook/content',
      queryParameters: {'page': page},
    ) as Map;
    final items = (response['data'] as List)
        .map((j) => ShortModel.fromListItemJson((j as Map).cast<String, dynamic>(), cookId: cookId))
        .toList();
    final meta = response['meta'] as Map?;
    final hasMore = meta != null && (meta['page'] as int) < (meta['totalPages'] as int);
    return PaginatedResult(
      items: items,
      hasMore: hasMore,
      nextCursor: hasMore ? '${page + 1}' : null,
    );
  }

  Future<ShortModel> createShort(ShortModel short) async {
    final fields = short.toApiRequestFields();
    if (!_isRemoteUrl(short.videoPath)) {
      fields['video'] = await MultipartFile.fromFile(short.videoPath);
    }
    final response = await _apiClient.post(
      '/user/cook/content',
      data: fields,
      isFormData: true,
    ) as Map;
    final data = (response['data'] as Map).cast<String, dynamic>();
    return ShortModel.fromApiJson(data)
        .copyWith(mealName: short.mealName, mealImageUrl: short.mealImageUrl);
  }

  Future<void> deleteShort(String id) async {
    await _apiClient.delete('/user/cook/content/$id');
  }

  bool _isRemoteUrl(String path) => path.startsWith('http://') || path.startsWith('https://');
}
