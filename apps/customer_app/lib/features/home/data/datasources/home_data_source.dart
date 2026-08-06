import '../../domain/entities/home_feed_entity.dart';

abstract class HomeDataSource {
  Future<HomeFeedEntity> getHomeFeed();
}
