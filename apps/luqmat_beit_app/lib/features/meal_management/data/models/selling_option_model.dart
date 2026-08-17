import 'package:core/core.dart';

/// The real API pairs every selling option with a `type` (e.g. "الحجم" —
/// "size") alongside its `variation` (e.g. "كبير" — "large"). The app's
/// variation-entry UI only ever captures one free-text label per option
/// (see `MealVariationRow`), so `type` is sent as this fixed default on
/// every write rather than a second user-entered field — [label] maps to
/// `variation`. Revisit if product wants cooks to choose the type
/// explicitly.
const String defaultSellingOptionType = 'الحجم';

class SellingOptionModel {
  const SellingOptionModel({
    required this.id,
    required this.label,
    required this.price,
  });

  final String id;
  final String label;
  final double price;

  factory SellingOptionModel.fromJson(Map<String, dynamic> json) => SellingOptionModel(
        id: json['id'] as String,
        label: json['label'] as String,
        price: (json['price'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'price': price,
      };

  /// Real-shape response parsing (`{id, type, variation, price}`) from
  /// `POST/PUT .../meals/{id}` — [label] takes `variation`, `type` is
  /// dropped on read (see [defaultSellingOptionType]).
  factory SellingOptionModel.fromApiJson(Map<String, dynamic> json) => SellingOptionModel(
        id: json['id'].toString(),
        label: json['variation'] as String? ?? '',
        price: double.tryParse(json['price']?.toString() ?? '') ?? 0,
      );

  /// Real-shape request fields for the meal create/update multipart body.
  Map<String, dynamic> toApiJson() => {
        'type': defaultSellingOptionType,
        'variation': label,
        'price': price,
      };

  SellingOptionEntity toEntity() => SellingOptionEntity(id: id, label: label, price: price);
}
