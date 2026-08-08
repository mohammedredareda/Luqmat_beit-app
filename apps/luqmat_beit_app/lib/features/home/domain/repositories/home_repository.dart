import 'package:core/core.dart';

import '../entities/home_feed_entity.dart';

abstract class HomeRepository {
  Future<Result<HomeFeedEntity>> getHomeFeed();
}
