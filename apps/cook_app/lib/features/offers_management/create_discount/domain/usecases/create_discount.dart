import 'package:core/core.dart';

import '../../../shared/domain/discount_form_submission.dart';
import '../repositories/create_discount_repository.dart';

class CreateDiscount {
  CreateDiscount(this._repository);

  final CreateDiscountRepository _repository;

  Future<Result<DiscountEntity>> call(DiscountFormSubmission submission) =>
      _repository.createDiscount(submission);
}
