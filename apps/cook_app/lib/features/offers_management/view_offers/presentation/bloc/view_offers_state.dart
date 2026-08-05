import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/offer_feed_item_entity.dart';

part 'view_offers_state.freezed.dart';

@freezed
class ViewOffersState with _$ViewOffersState {
  const factory ViewOffersState.initial() = ViewOffersInitial;
  const factory ViewOffersState.loading() = ViewOffersLoading;
  const factory ViewOffersState.loaded({
    required List<OfferFeedItemEntity> items,
    required bool hasMore,
    required bool isLoadingMore,
  }) = ViewOffersLoaded;
  const factory ViewOffersState.error(AppException exception) = ViewOffersError;
}
