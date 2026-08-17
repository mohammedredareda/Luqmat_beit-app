import 'package:core/core.dart';

import '../../../shared/domain/entities/short_management_entity.dart';
import '../../../shared/domain/short_form_submission.dart';

abstract class CreateShortRepository {
  Future<Result<ShortManagementEntity>> createShort(ShortFormSubmission submission);
}
