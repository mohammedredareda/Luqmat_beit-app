import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/delete_short.dart';
import 'delete_short_state.dart';

/// Mockup `_1`'s delete confirmation. A single linear confirm-then-mutate
/// flow, mirroring `DeleteDiscountCubit`.
class DeleteShortCubit extends Cubit<DeleteShortState> {
  DeleteShortCubit(this._deleteShort) : super(const DeleteShortState.initial());

  final DeleteShort _deleteShort;

  Future<void> delete(String shortId) async {
    emit(const DeleteShortState.submitting());
    final result = await _deleteShort(shortId);
    result.fold(
      (_) => emit(DeleteShortState.success(shortId)),
      (exception) => emit(DeleteShortState.failure(exception)),
    );
  }
}
