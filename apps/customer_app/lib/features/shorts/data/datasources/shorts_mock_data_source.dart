import '../../../../shared/mock/sample_catalog.dart';
import '../../domain/entities/short_entity.dart';

/// Stands in for `shorts_remote_data_source.dart` until a backend exists.
/// No real video assets are available, so each "short" reuses a meal image
/// from `SampleCatalog` as a static full-bleed placeholder frame — actual
/// video playback/decoding is out of scope for this pass.
///
/// TODO(backend): no shorts endpoint exists in the API collection at all.
class ShortsMockDataSource {
  final List<ShortEntity> _shorts = [
    ShortEntity(
      id: 'short-1',
      mealId: SampleCatalog.meals[0].id,
      cookName: SampleCatalog.meals[0].cookName,
      cookAvatarUrl: SampleCatalog.meals[0].cookAvatarUrl ?? '',
      thumbnailUrl: SampleCatalog.meals[0].imageUrl,
      caption: 'سر المقلوبة الأصلية بالباذنجان.. من المطبخ للقلب مباشرة ❤️ '
          '#لقمة_بيت #أكل_بيتي',
      likeCount: 1200,
      commentCount: 84,
      isLiked: false,
    ),
    ShortEntity(
      id: 'short-2',
      mealId: SampleCatalog.meals[1].id,
      cookName: SampleCatalog.meals[1].cookName,
      cookAvatarUrl: SampleCatalog.meals[1].cookAvatarUrl ?? '',
      thumbnailUrl: SampleCatalog.meals[1].imageUrl,
      caption: 'لفائف مسخن دجاج طازجة بالسماق والصنوبر 😍 #مسخن #أكل_فلسطيني',
      likeCount: 856,
      commentCount: 41,
      isLiked: true,
    ),
    ShortEntity(
      id: 'short-3',
      mealId: SampleCatalog.meals[2].id,
      cookName: SampleCatalog.meals[2].cookName,
      cookAvatarUrl: SampleCatalog.meals[0].cookAvatarUrl ?? '',
      thumbnailUrl: SampleCatalog.meals[2].imageUrl,
      caption: 'شوربة عدس فاخرة بالكمون والليمون.. دافئة ولذيذة 🍋',
      likeCount: 430,
      commentCount: 19,
      isLiked: false,
    ),
    ShortEntity(
      id: 'short-4',
      mealId: SampleCatalog.meals[3].id,
      cookName: SampleCatalog.meals[3].cookName,
      cookAvatarUrl: '',
      thumbnailUrl: SampleCatalog.meals[3].imageUrl,
      caption: 'بوكس فلافل منزلي مقرمش مع طحينة وسلطة 🌿 #فلافل',
      likeCount: 675,
      commentCount: 27,
      isLiked: false,
    ),
  ];

  Future<List<ShortEntity>> getShorts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_shorts);
  }

  Future<void> toggleLike(String shortId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _shorts.indexWhere((s) => s.id == shortId);
    if (index == -1) return;
    final short = _shorts[index];
    _shorts[index] = short.copyWith(
      isLiked: !short.isLiked,
      likeCount: short.isLiked ? short.likeCount - 1 : short.likeCount + 1,
    );
  }
}
