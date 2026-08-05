import 'package:cook_app/features/profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import 'package:cook_app/features/profile/domain/profile_form_submission.dart';
import 'package:cook_app/features/profile/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProfile returns the seeded cook profile', () async {
    final repository = EditProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile(currentCookId);

    expect(result, isA<Success<CookProfileEntity>>());
    expect((result as Success<CookProfileEntity>).data.fullName, 'أم أحمد');
  });

  test('updateProfile mutates and persists the new values', () async {
    final repository = EditProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    const submission = ProfileFormSubmission(
      fullName: 'سارة أحمد',
      phoneNumber: '+962 79 123 4567',
      bio: 'نبذة جديدة',
      address: 'عمان، دابوق',
      availabilityDays: {Weekday.saturday, Weekday.wednesday},
      availabilityStartTime: AvailabilityTime(hour: 9, minute: 0),
      availabilityEndTime: AvailabilityTime(hour: 17, minute: 0),
    );

    final result = await repository.updateProfile(currentCookId, submission);

    expect(result, isA<Success<CookProfileEntity>>());
    final updated = (result as Success<CookProfileEntity>).data;
    expect(updated.fullName, 'سارة أحمد');
    expect(updated.address, 'عمان، دابوق');

    final reloaded = await repository.getProfile(currentCookId);
    expect((reloaded as Success<CookProfileEntity>).data.fullName, 'سارة أحمد');
  });

  test('updateProfile with a null avatarPath keeps the existing avatarUrl', () async {
    final dataSource = FakeCookProfileRemoteDataSource();
    final repository = EditProfileRepositoryImpl(dataSource);

    const submission = ProfileFormSubmission(
      fullName: 'أم أحمد',
      phoneNumber: '+966 50 123 4567',
      bio: 'نبذة',
      address: 'الرياض',
      availabilityDays: {Weekday.sunday, Weekday.thursday},
      availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
      availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
    );

    final result = await repository.updateProfile(currentCookId, submission);

    expect((result as Success<CookProfileEntity>).data.avatarUrl, isNull);
  });
}
