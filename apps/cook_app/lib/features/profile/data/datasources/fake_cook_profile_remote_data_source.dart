import 'package:core/core.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../models/cook_profile_model.dart';

/// In-memory stand-in for the real Dio-backed data source — no backend
/// exists yet. Shared as one instance across both `view_profile` and
/// `edit_profile`, mirroring `FakeMealRemoteDataSource`'s role in
/// `meal_management`.
///
/// CK-21's performance stats are explicitly left undefined by the backlog
/// ("cannot be defined without further requirements") — this data source
/// deliberately does not seed/serve any such fields.
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
        availabilityTime: '10:00-18:00',
        rating: 4.9,
        reviewCount: 120,
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
