import 'package:core/core.dart';

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

  SellingOptionEntity toEntity() => SellingOptionEntity(id: id, label: label, price: price);
}
