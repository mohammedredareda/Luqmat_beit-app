import 'package:equatable/equatable.dart';

/// A lightweight chef/cook listing row — used by Home's "Featured Chefs"
/// (`GET /user/customer/get-cook`) and Search's `cooks` results
/// (`GET /user/customer/search`, `types` including `cooks`). Distinct from
/// any full chef-profile entity: only what a list row needs.
class ChefSummaryEntity extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final double rating;
  final int ratingCount;
  final double distanceKm;

  const ChefSummaryEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.ratingCount,
    required this.distanceKm,
  });

  @override
  List<Object?> get props =>
      [id, name, avatarUrl, rating, ratingCount, distanceKm];
}
