import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/view_profile_repository.dart';

@injectable
class GetCookProfile {
  GetCookProfile(this._repository);

  final ViewProfileRepository _repository;

  Future<Result<CookProfileEntity>> call(String cookId) => _repository.getProfile(cookId);
}
