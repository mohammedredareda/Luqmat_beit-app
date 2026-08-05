import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/view_menu_repository.dart';

@injectable
class SetSellingPaused {
  SetSellingPaused(this._repository);

  final ViewMenuRepository _repository;

  Future<Result<bool>> call({required String cookId, required bool isPaused}) =>
      _repository.setSellingPaused(cookId: cookId, isPaused: isPaused);
}
