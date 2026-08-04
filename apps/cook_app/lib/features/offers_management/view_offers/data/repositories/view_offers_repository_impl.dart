import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../../../shared/data/datasources/fake_offers_remote_data_source.dart';
import '../../../shared/data/models/discount_model.dart';
import '../../../shared/data/models/offer_model.dart';
import '../../domain/repositories/view_offers_repository.dart';

@LazySingleton(as: ViewOffersRepository)
class ViewOffersRepositoryImpl implements ViewOffersRepository {
  ViewOffersRepositoryImpl(this._offersDataSource, this._discountsDataSource);

  final FakeOffersRemoteDataSource _offersDataSource;
  final FakeDiscountsRemoteDataSource _discountsDataSource;

  @override
  Future<Result<({List<OfferEntity> offers, List<DiscountEntity> discounts})>>
      getOffersAndDiscounts(String cookId) {
    return guard(() async {
      final results = await Future.wait([
        _offersDataSource.getMyOffers(cookId),
        _discountsDataSource.getMyDiscounts(cookId),
      ]);
      final offerModels = results[0] as List<OfferModel>;
      final discountModels = results[1] as List<DiscountModel>;
      return (
        offers: offerModels.map((o) => o.toEntity()).toList(),
        discounts: discountModels.map((d) => d.toEntity()).toList(),
      );
    });
  }
}
