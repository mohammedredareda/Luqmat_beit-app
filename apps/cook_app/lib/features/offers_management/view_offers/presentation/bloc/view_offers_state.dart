import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_offers_state.freezed.dart';

@freezed
class ViewOffersState with _$ViewOffersState {
  const factory ViewOffersState.initial() = ViewOffersInitial;
  const factory ViewOffersState.loading() = ViewOffersLoading;
  const factory ViewOffersState.loaded({
    required List<OfferEntity> offers,
    required List<DiscountEntity> discounts,
  }) = ViewOffersLoaded;
  const factory ViewOffersState.error(AppException exception) = ViewOffersError;
}
