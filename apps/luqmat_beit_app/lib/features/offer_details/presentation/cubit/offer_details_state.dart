import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_details_state.freezed.dart';

/// The bundle itself is supplied directly (already fetched by whichever
/// screen navigated here — there's no `GET offer by id` endpoint), so this
/// only models the quantity stepper plus the add-to-cart submission —
/// a single fetch-and-display flow's one follow-up action, same shape as
/// `MealDetailsState`.
@freezed
sealed class OfferDetailsState with _$OfferDetailsState {
  const factory OfferDetailsState.idle({@Default(1) int quantity}) =
      OfferDetailsIdle;

  const factory OfferDetailsState.submitting({required int quantity}) =
      OfferDetailsSubmitting;

  const factory OfferDetailsState.addedToCart({required int quantity}) =
      OfferDetailsAddedToCart;

  const factory OfferDetailsState.failure({
    required int quantity,
    required AppException exception,
  }) = OfferDetailsFailure;
}

extension OfferDetailsStateQuantity on OfferDetailsState {
  int get quantity => switch (this) {
        OfferDetailsIdle(:final quantity) => quantity,
        OfferDetailsSubmitting(:final quantity) => quantity,
        OfferDetailsAddedToCart(:final quantity) => quantity,
        OfferDetailsFailure(:final quantity) => quantity,
      };
}
