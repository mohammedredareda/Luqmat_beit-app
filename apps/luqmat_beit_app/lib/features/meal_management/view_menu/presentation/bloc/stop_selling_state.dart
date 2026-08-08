import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_selling_state.freezed.dart';

@freezed
class StopSellingState with _$StopSellingState {
  const factory StopSellingState.initial() = StopSellingInitial;
  const factory StopSellingState.submitting() = StopSellingSubmitting;
  const factory StopSellingState.success(bool isSellingPaused) = StopSellingSuccess;
  const factory StopSellingState.failure(AppException exception) = StopSellingFailure;
}
