import 'package:core/core.dart';

import '../../../shared/domain/entities/short_management_entity.dart';
import '../../../shared/domain/short_form_submission.dart';
import '../repositories/create_short_repository.dart';

class CreateShort {
  CreateShort(this._repository);

  final CreateShortRepository _repository;

  Future<Result<ShortManagementEntity>> call(ShortFormSubmission submission) =>
      _repository.createShort(submission);
}
