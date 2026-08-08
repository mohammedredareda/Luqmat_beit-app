import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_offer_state.freezed.dart';

@freezed
class DeleteOfferState with _$DeleteOfferState {
  const factory DeleteOfferState.initial() = DeleteOfferInitial;
  const factory DeleteOfferState.submitting() = DeleteOfferSubmitting;
  const factory DeleteOfferState.success(String offerId) = DeleteOfferSuccess;
  const factory DeleteOfferState.failure(AppException exception) = DeleteOfferFailure;
}
