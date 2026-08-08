import 'package:equatable/equatable.dart';

/// The customer-facing counterpart of the cook module's `profile_with_stats`
/// mockup — same shell (avatar, stat cards, editable details, edit/save),
/// with cook-only fields (availability hours, "نبذة عني" bio, rating)
/// dropped and a delivery `address` kept instead.
class CustomerProfileEntity extends Equatable {
  const CustomerProfileEntity({
    required this.name,
    required this.phone,
    required this.address,
    required this.completedOrdersCount,
    required this.favoritesCount,
    this.avatarUrl,
  });

  final String name;
  final String phone;
  final String address;
  final int completedOrdersCount;
  final int favoritesCount;
  final String? avatarUrl;

  CustomerProfileEntity copyWith({String? name, String? address}) => CustomerProfileEntity(
        name: name ?? this.name,
        phone: phone,
        address: address ?? this.address,
        completedOrdersCount: completedOrdersCount,
        favoritesCount: favoritesCount,
        avatarUrl: avatarUrl,
      );

  @override
  List<Object?> get props =>
      [name, phone, address, completedOrdersCount, favoritesCount, avatarUrl];
}
