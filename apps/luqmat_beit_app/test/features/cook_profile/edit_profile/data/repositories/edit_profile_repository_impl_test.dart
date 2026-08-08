import 'package:luqmat_beit_app/features/cook_profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import 'package:luqmat_beit_app/features/cook_profile/domain/cook_profile_details.dart';
import 'package:luqmat_beit_app/features/cook_profile/domain/profile_form_submission.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProfile returns the seeded cook profile', () async {
    final repository = EditProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile(currentCookId);

    expect(result, isA<Success<CookProfileDetails>>());
    expect((result as Success<CookProfileDetails>).data.profile.name, 'أم أحمد');
  });

  test('updateProfile mutates and persists the new values', () async {
    final repository = EditProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    const submission = ProfileFormSubmission(
      fullName: 'سارة أحمد',
      phoneNumber: '+962 79 123 4567',
      bio: 'نبذة جديدة',
      address: 'عمان، دابوق',
      availabilityStartTime: '09:00',
      availabilityEndTime: '17:00',
    );

    final result = await repository.updateProfile(currentCookId, submission);

    expect(result, isA<Success<CookProfileDetails>>());
    final updated = (result as Success<CookProfileDetails>).data;
    expect(updated.profile.name, 'سارة أحمد');
    expect(updated.address, 'عمان، دابوق');

    final reloaded = await repository.getProfile(currentCookId);
    expect((reloaded as Success<CookProfileDetails>).data.profile.name, 'سارة أحمد');
  });

  test('updateProfile with a null avatarPath keeps the existing avatarUrl', () async {
    final dataSource = FakeCookProfileRemoteDataSource();
    final repository = EditProfileRepositoryImpl(dataSource);

    const submission = ProfileFormSubmission(
      fullName: 'أم أحمد',
      phoneNumber: '+966 50 123 4567',
      bio: 'نبذة',
      address: 'الرياض',
      availabilityStartTime: '10:00',
      availabilityEndTime: '18:00',
    );

    final result = await repository.updateProfile(currentCookId, submission);

    expect((result as Success<CookProfileDetails>).data.profile.photoUrl, isNull);
  });
}
