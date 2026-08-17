import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../models/short_model.dart';

/// In-memory stand-in for the cook-side Shorts endpoints — no such backend
/// exists yet (unlike meals/offers/discounts, there's no matching entry in
/// AI_INSTRUCTIONS' Postman collection or any confirmed endpoint), so this
/// mirrors `FakeDiscountsRemoteDataSource`'s shape rather than a real
/// `ShortsRemoteDataSource`. Swapping in a real Dio-backed data source later
/// only touches this file and its DI registration.
class FakeShortsRemoteDataSource {
  FakeShortsRemoteDataSource() : _shorts = List.of(_seed());

  final List<ShortModel> _shorts;

  static List<ShortModel> _seed() {
    final now = DateTime.now();
    return [
      ShortModel(
        id: 'short-1',
        cookId: currentCookId,
        videoPath: '',
        description: 'طريقة تحضير المنسف الأردني الأصيل خطوة بخطوة 😍',
        thumbnailUrl: 'https://picsum.photos/seed/mansaf-short/400/711',
        viewCount: 1200,
        createdAt: now.subtract(const Duration(days: 6)),
        mealId: 'meal-2',
        mealName: 'منسف أردني أصيل',
        mealImageUrl: 'https://picsum.photos/seed/mansaf/200/200',
      ),
      ShortModel(
        id: 'short-2',
        cookId: currentCookId,
        videoPath: '',
        description: 'كنافة نابلسية طازجة خارجة من الفرن الآن',
        thumbnailUrl: 'https://picsum.photos/seed/kunafa-short/400/711',
        viewCount: 850,
        createdAt: now.subtract(const Duration(days: 4)),
        mealId: 'meal-5',
        mealName: 'كنافة نابلسية',
        mealImageUrl: 'https://picsum.photos/seed/kunafa/200/200',
      ),
      ShortModel(
        id: 'short-3',
        cookId: currentCookId,
        videoPath: '',
        description: 'جولة سريعة داخل مطبخي وأنا أحضّر طلبات اليوم',
        thumbnailUrl: 'https://picsum.photos/seed/kitchen-short/400/711',
        viewCount: 420,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ShortModel(
        id: 'short-4',
        cookId: currentCookId,
        videoPath: '',
        description: 'سر تتبيلة الشيش طاووق اللي بتجنن كل زباين مطبخي',
        thumbnailUrl: 'https://picsum.photos/seed/tawook-short/400/711',
        viewCount: 2100,
        createdAt: now.subtract(const Duration(days: 1)),
        mealId: 'meal-6',
        mealName: 'شيش طاووق',
        mealImageUrl: 'https://picsum.photos/seed/tawook/200/200',
      ),
      ShortModel(
        id: 'short-5',
        cookId: currentCookId,
        videoPath: '',
        description: 'وصفة حمص بالصنوبر بطريقة سهلة وسريعة في المنزل',
        thumbnailUrl: 'https://picsum.photos/seed/hummus-short/400/711',
        viewCount: 300,
        createdAt: now.subtract(const Duration(hours: 10)),
        mealId: 'meal-4',
        mealName: 'حمص بالصنوبر',
        mealImageUrl: 'https://picsum.photos/seed/hummus/200/200',
      ),
      ShortModel(
        id: 'short-6',
        cookId: currentCookId,
        videoPath: '',
        description: 'شكراً لكل زباين مطبخي على دعمكم المستمر ❤️',
        thumbnailUrl: 'https://picsum.photos/seed/thanks-short/400/711',
        viewCount: 95,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
    ];
  }

  Future<List<ShortModel>> getMyShorts(String cookId) async => _shorts
      .where((s) => s.cookId == cookId && s.deletedAt == null)
      .toList(growable: false)
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  Future<ShortModel> createShort(ShortModel short) async {
    _shorts.add(short);
    return short;
  }

  /// Never blocked, proceeds straight through — mirrors CK-15's discount
  /// soft-delete convention (`FakeDiscountsRemoteDataSource.deleteDiscount`).
  Future<void> deleteShort(String id) async {
    final index = _shorts.indexWhere((s) => s.id == id);
    if (index == -1) throw const NotFoundException('Short not found');
    _shorts[index] = _shorts[index].copyWith(deletedAt: DateTime.now());
  }
}
