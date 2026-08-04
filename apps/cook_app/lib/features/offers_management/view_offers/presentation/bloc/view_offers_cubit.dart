import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../domain/usecases/get_offers_and_discounts.dart';
import 'view_offers_state.dart';

/// CK-11 View Offers & Discounts — a single fetch-and-display flow,
/// matching `ViewMenuCubit`.
@injectable
class ViewOffersCubit extends Cubit<ViewOffersState> {
  ViewOffersCubit(this._getOffersAndDiscounts) : super(const ViewOffersState.initial());

  final GetOffersAndDiscounts _getOffersAndDiscounts;

  Future<void> load() async {
    emit(const ViewOffersState.loading());
    final result = await _getOffersAndDiscounts(currentCookId);
    result.fold(
      (data) => emit(ViewOffersState.loaded(offers: data.offers, discounts: data.discounts)),
      (exception) => emit(ViewOffersState.error(exception)),
    );
  }
}
