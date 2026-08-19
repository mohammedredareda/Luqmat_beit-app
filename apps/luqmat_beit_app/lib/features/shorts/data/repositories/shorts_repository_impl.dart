import 'package:core/core.dart';

import '../../domain/entities/short_comment_entity.dart';
import '../../domain/entities/short_entity.dart';
import '../../domain/repositories/shorts_repository.dart';
import '../datasources/shorts_data_source.dart';

class ShortsRepositoryImpl implements ShortsRepository {
  ShortsRepositoryImpl({required ShortsDataSource dataSource})
      : _dataSource = dataSource;

  final ShortsDataSource _dataSource;

  @override
  Future<Result<PaginatedResult<ShortEntity>>> getFeed({String? cursor}) {
    return guard(() => _dataSource.getFeed(cursor: cursor));
  }

  @override
  Future<Result<void>> markViewed(String shortId) {
    return guard(() => _dataSource.markViewed(shortId));
  }

  @override
  Future<Result<bool>> toggleReact(String shortId) {
    return guard(() => _dataSource.toggleReact(shortId));
  }

  @override
  Future<Result<PaginatedResult<ShortCommentEntity>>> getComments(
    String shortId, {
    String? cursor,
  }) {
    return guard(() => _dataSource.getComments(shortId, cursor: cursor));
  }

  @override
  Future<Result<ShortCommentEntity>> addComment(String shortId, String text) {
    return guard(() => _dataSource.addComment(shortId, text));
  }
}
