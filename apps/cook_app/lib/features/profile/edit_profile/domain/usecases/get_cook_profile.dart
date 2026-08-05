import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/edit_profile_repository.dart';

@injectable
class GetCookProfile {
  GetCookProfile(this._repository);

  final EditProfileRepository _repository;

  Future<Result<CookProfileEntity>> call(String cookId) => _repository.getProfile(cookId);
}
