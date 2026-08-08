import 'package:core/core.dart';

import '../../../shared/data/datasources/fake_offers_remote_data_source.dart';
import '../../domain/repositories/delete_offer_repository.dart';

class DeleteOfferRepositoryImpl implements DeleteOfferRepository {
  DeleteOfferRepositoryImpl(this._dataSource);

  final FakeOffersRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteOffer(String offerId) {
    return guard(() => _dataSource.deleteOffer(offerId));
  }
}
