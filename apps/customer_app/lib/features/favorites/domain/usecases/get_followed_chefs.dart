import 'package:core/core.dart';

import '../../../home/domain/entities/home_feed_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFollowedChefs {
  const GetFollowedChefs(this._repository);

  final FavoritesRepository _repository;

  Future<Result<List<ChefSummaryEntity>>> call() => _repository.getFollowedChefs();
}
