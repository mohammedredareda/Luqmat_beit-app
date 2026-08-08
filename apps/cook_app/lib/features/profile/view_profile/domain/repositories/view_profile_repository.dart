import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';

abstract class ViewProfileRepository {
  Future<Result<CookProfileDetails>> getProfile(String cookId);
}
