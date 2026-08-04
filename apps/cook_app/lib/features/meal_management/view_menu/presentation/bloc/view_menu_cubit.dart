import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_my_meals.dart';
import 'view_menu_state.dart';

/// CK-06 View My Menu — a single fetch-and-display flow (loading/loaded/
/// error, no branching outcomes), which is exactly the criterion the
/// architecture doc uses to pick Cubit over Bloc.
@injectable
class ViewMenuCubit extends Cubit<ViewMenuState> {
  ViewMenuCubit(this._getMyMeals) : super(const ViewMenuState.initial());

  final GetMyMeals _getMyMeals;

  Future<void> loadMenu() async {
    emit(const ViewMenuState.loading());
    final result = await _getMyMeals(currentCookId);
    result.fold(
      (data) => emit(ViewMenuState.loaded(
        meals: data.meals,
        isSellingPaused: data.isSellingPaused,
      )),
      (exception) => emit(ViewMenuState.error(exception)),
    );
  }
}
