import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/view_menu_repository.dart';

@injectable
class GetMyMeals {
  GetMyMeals(this._repository);

  final ViewMenuRepository _repository;

  Future<Result<({List<MealEntity> meals, bool isSellingPaused})>> call(
    String cookId,
  ) =>
      _repository.getMyMeals(cookId);
}
