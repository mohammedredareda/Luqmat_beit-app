import 'package:core/core.dart';

import '../../../../shared/mock/sample_catalog.dart';
import 'search_data_source.dart';

/// Stands in for `search_remote_data_source.dart` until a backend exists.
/// Filters/sorts/paginates `SampleCatalog.meals` in memory. Same call shape
/// a real Dio-backed datasource would have, so swapping it in later doesn't
/// touch the repository.
class SearchMockDataSource implements SearchDataSource {
  @override
  Future<PaginatedResult<MealEntity>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = PaginationConstants.defaultPageSize,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final normalizedQuery = query.trim();
    var results = SampleCatalog.meals.where((meal) {
      if (normalizedQuery.isEmpty) return true;
      return meal.name.contains(normalizedQuery) ||
          meal.description.contains(normalizedQuery) ||
          meal.cookName.contains(normalizedQuery) ||
          meal.tags.any((tag) => tag.contains(normalizedQuery));
    }).toList();

    final categoryId = filters?['categoryId'] as String?;
    if (categoryId != null) {
      final category = SampleCatalog.categories.firstWhere(
        (c) => c.id == categoryId,
        orElse: () => SampleCatalog.categories.first,
      );
      results = results.where((meal) => meal.tags.contains(category.label)).toList();
    }

    switch (filters?['sort'] as String?) {
      case 'topRated':
        results.sort((a, b) => b.rating.compareTo(a.rating));
      case 'priceLowToHigh':
        results.sort((a, b) => a.startingPrice.compareTo(b.startingPrice));
      case 'priceHighToLow':
        results.sort((a, b) => b.startingPrice.compareTo(a.startingPrice));
      case 'nearest':
      default:
        // MealEntity carries no distance field yet — catalog order stands
        // in for "nearest" until a location-aware backend exists.
        break;
    }

    final start = cursor == null ? 0 : int.parse(cursor);
    final end = (start + pageSize).clamp(0, results.length);
    final page = start >= results.length ? const <MealEntity>[] : results.sublist(start, end);
    final hasMore = end < results.length;

    return PaginatedResult<MealEntity>(
      items: page,
      hasMore: hasMore,
      nextCursor: hasMore ? end.toString() : null,
    );
  }
}
