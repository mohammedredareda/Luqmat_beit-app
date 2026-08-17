import 'package:core/core.dart';
import 'package:dio/dio.dart' show MultipartFile;

import '../models/offer_model.dart';

/// Real Dio-backed data source for the offers endpoints — replaces
/// `FakeOffersRemoteDataSource` entirely now that a GET-by-id
/// (`GET /user/cook/menu/offers/{id}`) is documented, so `updateOffer`'s
/// prefill can be real too.
class OffersRemoteDataSource {
  OffersRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<OfferModel> createOffer(OfferModel offer) async {
    final fields = await _multipartFields(offer);
    await _apiClient.post('/user/cook/menu/offers/create', data: fields, isFormData: true);
    // No created-offer payload in the response — same reasoning as
    // MealRemoteDataSource.createMeal.
    return offer;
  }

  Future<OfferModel?> getOfferById(String id) async {
    final response = await _apiClient.get('/user/cook/menu/offers/$id') as Map;
    final data = response['data'];
    if (data is! Map) return null;
    return OfferModel.fromApiJson(data.cast<String, dynamic>());
  }

  Future<OfferModel> updateOffer(OfferModel offer) async {
    final fields = await _multipartFields(offer);
    await _apiClient.put('/user/cook/menu/offers/${offer.id}', data: fields, isFormData: true);
    // The edit-offer example response only documents the 409 Conflict
    // case, not a 200 success payload — re-fetch to get the authoritative
    // saved state instead of guessing at a success-response shape.
    final saved = await getOfferById(offer.id);
    if (saved == null) throw const NotFoundException('Offer not found');
    return saved;
  }

  /// Confirmed live: `DELETE /user/cook/menu/offers/{id}`.
  Future<void> deleteOffer(String id) async {
    await _apiClient.delete('/user/cook/menu/offers/$id');
  }

  Future<Map<String, dynamic>> _multipartFields(OfferModel offer) async {
    final fields = offer.toApiRequestFields();
    final imageUrl = offer.imageUrl;
    if (imageUrl != null && imageUrl.isNotEmpty && !_isRemoteUrl(imageUrl)) {
      fields['image'] = await MultipartFile.fromFile(imageUrl);
    }
    return fields;
  }

  bool _isRemoteUrl(String path) => path.startsWith('http://') || path.startsWith('https://');
}
