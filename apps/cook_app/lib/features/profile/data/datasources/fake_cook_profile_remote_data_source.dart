import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/cook_profile_model.dart';

/// In-memory stand-in for the real Dio-backed data source — no backend
/// exists yet. Shared as one `@lazySingleton` instance across both
/// `view_profile` and `edit_profile`, mirroring
/// `FakeMealRemoteDataSource`'s role in `meal_management`.
///
/// The stats (`rating`/`reviewCount`/`completedOrdersCount`/
/// `totalMealsCount`) are static seed values, not derived from any other
/// feature's data — CK-21 is explicitly marked incomplete in the backlog,
/// with no confirmed calculation rules, so they're mocked rather than
/// wired to a real aggregate.
@lazySingleton
class FakeCookProfileRemoteDataSource {
  FakeCookProfileRemoteDataSource() : _profile = _seed();

  CookProfileModel _profile;

  static CookProfileModel _seed() => const CookProfileModel(
        id: currentCookId,
        fullName: 'أم أحمد',
        phoneNumber: '+966 50 123 4567',
        bio: 'طباخة منزلية متخصصة في الأكلات الشامية العريقة. أقدم لكم أشهى الوصفات '
            'المحضرة بحب وعناية، تماماً كما أعدها لعائلتي. خبرة أكثر من 20 عاماً في المطبخ.',
        address: 'حي الياسمين، شارع أبي بكر الصديق، الرياض',
        availabilityDays: {
          Weekday.sunday,
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
        },
        availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
        availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
        rating: 4.9,
        reviewCount: 120,
        completedOrdersCount: 124,
        totalMealsCount: 15,
        avatarUrl: null,
      );

  Future<CookProfileModel> getProfile(String cookId) async {
    if (_profile.id != cookId) throw const NotFoundException('Profile not found');
    return _profile;
  }

  Future<CookProfileModel> updateProfile(CookProfileModel profile) async {
    if (_profile.id != profile.id) throw const NotFoundException('Profile not found');
    return _profile = profile;
  }
}
