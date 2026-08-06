import 'package:core/core.dart';

import '../entities/short_entity.dart';

abstract class ShortsRepository {
  Future<Result<List<ShortEntity>>> getShorts();

  Future<Result<void>> toggleLike(String shortId);
}
