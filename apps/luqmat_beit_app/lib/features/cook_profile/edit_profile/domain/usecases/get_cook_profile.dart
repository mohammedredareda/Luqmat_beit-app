import 'package:core/core.dart';

import '../../../domain/cook_profile_details.dart';
import '../repositories/edit_profile_repository.dart';

class GetCookProfile {
  GetCookProfile(this._repository);

  final EditProfileRepository _repository;

  Future<Result<CookProfileDetails>> call(String cookId) => _repository.getProfile(cookId);
}
