import '../../../../shared/mock/sample_catalog.dart';
import '../../domain/entities/home_feed_entity.dart';
import 'home_data_source.dart';

/// Stands in for `home_remote_data_source.dart` until a backend exists.
/// Same call shape (`Future<...>`) a real Dio-backed datasource would have,
/// so swapping it in later doesn't touch the repository.
class HomeMockDataSource implements HomeDataSource {
  @override
  Future<HomeFeedEntity> getHomeFeed() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HomeFeedEntity(
      categories: SampleCatalog.categories,
      bestSellers: SampleCatalog.meals.take(2).toList(),
      chefs: SampleCatalog.chefs,
      offerBundles: const [],
      discountedMeals: SampleCatalog.meals.skip(2).toList(),
      discountsByMealId: SampleCatalog.discountsByMealId,
      returnedMeals: const [],
    );
  }
}
