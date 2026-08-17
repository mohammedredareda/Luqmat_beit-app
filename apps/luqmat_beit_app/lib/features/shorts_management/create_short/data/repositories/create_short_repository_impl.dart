import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../../shared/data/datasources/fake_shorts_remote_data_source.dart';
import '../../../shared/data/models/short_model.dart';
import '../../../shared/domain/entities/short_management_entity.dart';
import '../../../shared/domain/short_form_submission.dart';
import '../../domain/repositories/create_short_repository.dart';

class CreateShortRepositoryImpl implements CreateShortRepository {
  CreateShortRepositoryImpl(this._dataSource);

  final FakeShortsRemoteDataSource _dataSource;

  @override
  Future<Result<ShortManagementEntity>> createShort(ShortFormSubmission submission) {
    return guard(() async {
      final now = DateTime.now();
      final model = ShortModel(
        id: 'short-${now.microsecondsSinceEpoch}',
        cookId: currentCookId,
        videoPath: submission.videoPath,
        description: submission.description,
        viewCount: 0,
        createdAt: now,
        mealId: submission.mealId,
        mealName: submission.mealName,
        mealImageUrl: submission.mealImageUrl,
      );
      final created = await _dataSource.createShort(model);
      return created.toEntity();
    });
  }
}
