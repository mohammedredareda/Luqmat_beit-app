import 'package:core/core.dart';

import '../entities/home_feed_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeFeed {
  const GetHomeFeed(this._repository);

  final HomeRepository _repository;

  Future<Result<HomeFeedEntity>> call() => _repository.getHomeFeed();
}
