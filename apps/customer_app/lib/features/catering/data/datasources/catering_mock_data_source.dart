import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import '../../domain/entities/catering_request_entity.dart';

/// Stands in for `catering_remote_data_source.dart` until a backend exists.
/// The draft mirrors the approved mockup (catering_review_s12/code.html):
/// two high-quantity meal line items (منسف أردني x15, مسخن فلسطيني x10)
/// that add up to the "المجموع التقريبي" total shown there.
///
/// TODO(backend): no catering endpoint exists in the API collection at all.
class CateringMockDataSource {
  CateringRequestEntity? _draft;

  Future<CateringRequestEntity> getDraftRequest() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final mansaf = SampleCatalog.mealById('meal-1');
    final musakhan = SampleCatalog.mealById('meal-2');

    final items = <CartItemEntity>[
      CartItemEntity(
        id: 'catering-item-1',
        meal: mansaf,
        sellingOption: mansaf.sellingOptions.first,
        quantity: 15,
      ),
      CartItemEntity(
        id: 'catering-item-2',
        meal: musakhan,
        sellingOption: musakhan.sellingOptions.first,
        quantity: 10,
      ),
    ];

    _draft = CateringRequestEntity(
      id: 'catering-draft-1',
      items: items,
      guestCount: 25,
      eventDate: DateTime.now().add(const Duration(days: 7)),
      deliveryAddress: 'عمّان، شارع الرينبو، مبنى 12',
      totalEstimate: items.fold<double>(0, (sum, item) => sum + item.subtotal),
    );
    return _draft!;
  }

  Future<void> submitRequest(CateringRequestEntity request) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _draft = request;
  }
}
