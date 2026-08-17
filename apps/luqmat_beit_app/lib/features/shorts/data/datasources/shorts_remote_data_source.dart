import 'package:core/core.dart';

import '../../domain/entities/short_comment_entity.dart';
import '../../domain/entities/short_entity.dart';
import 'shorts_data_source.dart';

/// Real implementation, backed by the backend's `ContentController`
/// (`GET/POST /user/customer/content/...`). `cursor` maps to the backend's
/// numeric `page` query param, same convention as search/orders.
class ShortsRemoteDataSource implements ShortsDataSource {
  ShortsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PaginatedResult<ShortEntity>> getFeed({String? cursor}) async {
    final page = cursor == null ? 1 : int.tryParse(cursor) ?? 1;
    final response =
        await _apiClient.get('/user/customer/content/feed', queryParameters: {'page': page});

    final itemsJson = (response as Map)['items'] as List? ?? const [];
    final next = response['next'];

    return PaginatedResult<ShortEntity>(
      items: itemsJson.map((i) => _shortFromJson(i as Map)).toList(),
      hasMore: next != null,
      nextCursor: next?.toString(),
    );
  }

  @override
  Future<void> markViewed(String shortId) async {
    await _apiClient.post('/user/customer/content/$shortId/view');
  }

  @override
  Future<bool> toggleReact(String shortId) async {
    final response = await _apiClient.post('/user/customer/content/$shortId/react');
    return (response as Map)['reacted'] as bool? ?? false;
  }

  @override
  Future<PaginatedResult<ShortCommentEntity>> getComments(
    String shortId, {
    String? cursor,
  }) async {
    final page = cursor == null ? 1 : int.tryParse(cursor) ?? 1;
    final response = await _apiClient.get(
      '/user/customer/content/$shortId/comments',
      queryParameters: {'page': page},
    );

    final itemsJson = (response as Map)['items'] as List? ?? const [];
    final next = response['next'];

    return PaginatedResult<ShortCommentEntity>(
      items: itemsJson.map((i) => _commentFromJson(i as Map)).toList(),
      hasMore: next != null,
      nextCursor: next?.toString(),
    );
  }

  @override
  Future<ShortCommentEntity> addComment(String shortId, String text) async {
    final response = await _apiClient.post(
      '/user/customer/content/$shortId/comments',
      data: {'text': text},
    );
    final data = (response as Map)['data'] as Map? ?? const {};
    return ShortCommentEntity(
      id: (data['id'] ?? DateTime.now().millisecondsSinceEpoch).toString(),
      text: data['text'] as String? ?? text,
      customerName: '',
      createdAt: DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  ShortEntity _shortFromJson(Map json) {
    final cook = json['cook'] as Map? ?? const {};
    final meal = json['meal'] as Map?;

    return ShortEntity(
      id: json['content_id'].toString(),
      mealId: meal?['meal_id']?.toString(),
      cookId: cook['cook_id']?.toString() ?? '',
      cookName: cook['name'] as String? ?? '',
      cookAvatarUrl: cook['image'] as String? ?? '',
      videoUrl: json['url'] as String? ?? '',
      caption: json['description'] as String? ?? '',
      likeCount: (json['reacts_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comments_count'] as num?)?.toInt() ?? 0,
      viewCount: (json['views_count'] as num?)?.toInt() ?? 0,
      isLiked: json['is_reacted'] as bool? ?? false,
    );
  }

  ShortCommentEntity _commentFromJson(Map json) {
    final customer = json['customer'] as Map? ?? const {};
    return ShortCommentEntity(
      id: json['comment_id'].toString(),
      text: json['text'] as String? ?? '',
      customerName: customer['name'] as String? ?? '',
      customerAvatarUrl: customer['image'] as String?,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}
