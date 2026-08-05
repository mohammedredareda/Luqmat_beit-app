import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/fake_cook_profile_remote_data_source.dart';
import '../../../domain/profile_form_submission.dart';
import '../../domain/repositories/edit_profile_repository.dart';

@LazySingleton(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  EditProfileRepositoryImpl(this._dataSource);

  final FakeCookProfileRemoteDataSource _dataSource;

  @override
  Future<Result<CookProfileEntity>> getProfile(String cookId) {
    return guard(() async {
      final model = await _dataSource.getProfile(cookId);
      return model.toEntity();
    });
  }

  @override
  Future<Result<CookProfileEntity>> updateProfile(
    String cookId,
    ProfileFormSubmission submission,
  ) {
    return guard(() async {
      final existing = await _dataSource.getProfile(cookId);

      final updated = existing.copyWith(
        fullName: submission.fullName,
        phoneNumber: submission.phoneNumber,
        bio: submission.bio,
        address: submission.address,
        availabilityDays: submission.availabilityDays,
        availabilityStartTime: submission.availabilityStartTime,
        availabilityEndTime: submission.availabilityEndTime,
        avatarUrl: submission.avatarPath,
      );

      final saved = await _dataSource.updateProfile(updated);
      return saved.toEntity();
    });
  }
}
