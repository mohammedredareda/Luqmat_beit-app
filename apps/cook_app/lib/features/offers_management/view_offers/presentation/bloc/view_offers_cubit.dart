import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/entities/offer_feed_filter.dart';
import '../../domain/entities/offer_feed_item_entity.dart';
import '../../domain/usecases/get_offers_feed.dart';
import 'view_offers_state.dart';

/// CK-11 View Offers & Discounts — a single fetch-and-display flow,
/// matching `ViewMenuCubit`. Paginated via [PaginationStateMixin]: `load`
/// resets to page one (also on a filter change, never appending onto a
/// stale list), `loadMore` fetches the next page of the merged feed.
@injectable
class ViewOffersCubit extends Cubit<ViewOffersState> with PaginationStateMixin<OfferFeedItemEntity> {
  ViewOffersCubit(this._getOffersFeed) : super(const ViewOffersState.initial());

  final GetOffersFeed _getOffersFeed;

  OfferFeedFilter _filter = OfferFeedFilter.all;
  OfferFeedFilter get filter => _filter;

  Future<void> load({OfferFeedFilter? filter}) async {
    _filter = filter ?? _filter;
    resetPagination();
    emit(const ViewOffersState.loading());
    final result = await _getOffersFeed(currentCookId, filter: _filter);
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewOffersState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) => emit(ViewOffersState.error(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;
    isLoadingMore = true;
    emit(ViewOffersState.loaded(items: items, hasMore: hasMore, isLoadingMore: true));
    final result = await _getOffersFeed(currentCookId, filter: _filter, cursor: cursor);
    result.fold(
      (page) {
        appendPage(page);
        emit(ViewOffersState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
      (exception) {
        isLoadingMore = false;
        emit(ViewOffersState.loaded(items: items, hasMore: hasMore, isLoadingMore: false));
      },
    );
  }
}
