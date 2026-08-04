import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/set_selling_paused.dart';
import 'stop_selling_state.dart';

/// CK-10 Stop Selling. The confirm/cancel branch point lives in the
/// confirmation dialog's own return value (awaited by the calling
/// widget before this is ever invoked) rather than as emitted states
/// here — that keeps this a single linear fetch-and-mutate shape, the
/// same Cubit-over-Bloc reasoning as [ViewMenuCubit].
@injectable
class StopSellingCubit extends Cubit<StopSellingState> {
  StopSellingCubit(this._setSellingPaused) : super(const StopSellingState.initial());

  final SetSellingPaused _setSellingPaused;

  Future<void> setPaused(bool isPaused) async {
    emit(const StopSellingState.submitting());
    final result = await _setSellingPaused(cookId: currentCookId, isPaused: isPaused);
    result.fold(
      (paused) => emit(StopSellingState.success(paused)),
      (exception) => emit(StopSellingState.failure(exception)),
    );
  }
}
