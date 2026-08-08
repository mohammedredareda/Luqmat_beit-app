import 'package:core/core.dart';

import '../repositories/favorites_repository.dart';

class UnfollowChef {
  const UnfollowChef(this._repository);

  final FavoritesRepository _repository;

  Future<Result<void>> call(String chefId) => _repository.unfollowChef(chefId);
}
