import 'package:cook_app/features/profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import 'package:cook_app/features/profile/data/models/cook_profile_model.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeCookProfileRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeCookProfileRemoteDataSource();
  });

  test('getProfile returns the seeded profile for the current cook', () async {
    final profile = await dataSource.getProfile(currentCookId);

    expect(profile.id, currentCookId);
    expect(profile.fullName, 'أم أحمد');
    expect(profile.rating, 4.9);
  });

  test('getProfile with an unknown id throws NotFoundException', () async {
    expect(
      () => dataSource.getProfile('cook-does-not-exist'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('updateProfile mutates in place and is reflected on next getProfile', () async {
    final existing = await dataSource.getProfile(currentCookId);
    final updated = existing.copyWith(fullName: 'سارة أحمد', address: 'عمان، دابوق');

    await dataSource.updateProfile(updated);

    final reloaded = await dataSource.getProfile(currentCookId);
    expect(reloaded.fullName, 'سارة أحمد');
    expect(reloaded.address, 'عمان، دابوق');
  });

  test('updateProfile with a mismatched id throws NotFoundException', () async {
    const mismatched = CookProfileModel(
      id: 'cook-does-not-exist',
      fullName: 'x',
      phoneNumber: 'x',
      bio: 'x',
      address: 'x',
      availabilityTime: '09:00-17:00',
      rating: 0,
      reviewCount: 0,
    );

    expect(
      () => dataSource.updateProfile(mismatched),
      throwsA(isA<NotFoundException>()),
    );
  });
}
