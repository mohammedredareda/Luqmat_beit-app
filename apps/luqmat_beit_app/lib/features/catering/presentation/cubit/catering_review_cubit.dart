import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_catering_draft.dart';
import '../../domain/usecases/submit_catering_request.dart';
import 'catering_review_state.dart';

class CateringReviewCubit extends Cubit<CateringReviewState> {
  CateringReviewCubit(this._getCateringDraft, this._submitCateringRequest)
      : super(const CateringReviewState.initial());

  final GetCateringDraft _getCateringDraft;
  final SubmitCateringRequest _submitCateringRequest;

  Future<void> loadDraft() async {
    emit(const CateringReviewState.loading());
    final result = await _getCateringDraft();
    result.fold(
      (request) => emit(CateringReviewState.loaded(request)),
      (exception) => emit(CateringReviewState.failure(exception)),
    );
  }

  Future<void> submit() async {
    final current = state;
    if (current is! CateringReviewLoaded) return;
    final request = current.request;
    emit(CateringReviewState.submitting(request));
    final result = await _submitCateringRequest(request);
    result.fold(
      (_) => emit(CateringReviewState.submitted(request)),
      (exception) => emit(CateringReviewState.failure(exception)),
    );
  }
}
