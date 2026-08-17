import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/short_management_entity.dart';

part 'short_submit_status.freezed.dart';

/// The submit outcome sub-state backing `CreateShortState`, mirroring
/// `DiscountSubmitStatus`'s shape.
@freezed
class ShortSubmitStatus with _$ShortSubmitStatus {
  const factory ShortSubmitStatus.idle() = ShortSubmitIdle;
  const factory ShortSubmitStatus.submitting() = ShortSubmitSubmitting;
  const factory ShortSubmitStatus.validationFailure(
    Map<String, List<String>> fieldErrors,
  ) = ShortSubmitValidationFailure;
  const factory ShortSubmitStatus.success(ShortManagementEntity short) = ShortSubmitSuccess;
  const factory ShortSubmitStatus.failure(AppException exception) = ShortSubmitFailure;
}
