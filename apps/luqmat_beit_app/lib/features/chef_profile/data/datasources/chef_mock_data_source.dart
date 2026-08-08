import '../../../../shared/mock/sample_catalog.dart';
import '../../../home/domain/entities/home_feed_entity.dart';
import '../../domain/entities/chef_profile_entity.dart';
import 'chef_data_source.dart';

/// Stands in for `chef_remote_data_source.dart` until a backend exists.
/// Same call shape a real Dio-backed datasource would have, so swapping it
/// in later doesn't touch the repository. Follow state is kept in-memory
/// here (per process, not persisted) since there is no auth/session layer
/// yet to hang a real "my follows" list off of.
class ChefMockDataSource implements ChefDataSource {
  final Map<String, bool> _followState = {};

  static const _bios = <String, String>{
    'cook-1':
        'أطباق شامية أصيلة مطبوخة بحب من مطبخي لمائدتكم. متخصصون في المحاشي والمقالي.',
    'cook-2': 'مطبخ فلسطيني تراثي، مسخن وأطباق منزلية طازجة تُحضَّر يوميًا.',
    'cook-3': 'متخصصون في الفلافل والمقبلات الطازجة على الطريقة المنزلية.',
  };

  @override
  Future<ChefProfileEntity> getChefProfile(String chefId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final meals = SampleCatalog.meals.where((m) => m.cookId == chefId).toList();

    final summary = SampleCatalog.chefs.firstWhere(
      (c) => c.id == chefId,
      orElse: () => ChefSummaryEntity(
        id: chefId,
        name: meals.isNotEmpty ? meals.first.cookName : 'شيف لُقمة بيت',
        avatarUrl: meals.isNotEmpty && meals.first.cookAvatarUrl != null
            ? meals.first.cookAvatarUrl!
            : SampleCatalog.chefs.first.avatarUrl,
        rating: meals.isNotEmpty
            ? meals.map((m) => m.rating).reduce((a, b) => a + b) / meals.length
            : 4.5,
        ratingCount: meals.fold<int>(0, (sum, m) => sum + m.ratingCount),
        distanceKm: 3.0,
      ),
    );

    return ChefProfileEntity(
      id: summary.id,
      name: summary.name,
      avatarUrl: summary.avatarUrl,
      bio: _bios[chefId] ??
          'طهاة منزليون شغوفون بتقديم أشهى الأطباق البيتية لمائدتكم.',
      rating: summary.rating,
      ratingCount: summary.ratingCount,
      distanceKm: summary.distanceKm,
      isFollowing: _followState[chefId] ?? false,
      meals: meals,
    );
  }

  @override
  Future<void> toggleFollow(String chefId, {required bool wasFollowing}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _followState[chefId] = !wasFollowing;
  }
}
