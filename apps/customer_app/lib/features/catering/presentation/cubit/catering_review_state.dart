import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/catering_request_entity.dart';

part 'catering_review_state.freezed.dart';

/// Single fetch-and-display flow (CU-25: review the draft, then submit
/// for human verification) — a Cubit, not a Bloc, per the architecture
/// doc's §6 decision rule. `submitting`/`submitted` are modeled as
/// distinct states off of `loaded` so the request data always stays on
/// screen while the "قيد المراجعة" confirmation is shown.
@freezed
sealed class CateringReviewState with _$CateringReviewState {
  const factory CateringReviewState.initial() = CateringReviewInitial;
  const factory CateringReviewState.loading() = CateringReviewLoading;
  const factory CateringReviewState.loaded(CateringRequestEntity request) =
      CateringReviewLoaded;
  const factory CateringReviewState.submitting(CateringRequestEntity request) =
      CateringReviewSubmitting;
  const factory CateringReviewState.submitted(CateringRequestEntity request) =
      CateringReviewSubmitted;
  const factory CateringReviewState.failure(AppException exception) =
      CateringReviewFailure;
}
