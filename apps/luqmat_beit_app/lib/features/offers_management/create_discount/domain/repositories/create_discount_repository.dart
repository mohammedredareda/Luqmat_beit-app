import 'package:core/core.dart';

import '../../../shared/domain/discount_form_submission.dart';

abstract class CreateDiscountRepository {
  Future<Result<DiscountEntity>> createDiscount(DiscountFormSubmission submission);
}
