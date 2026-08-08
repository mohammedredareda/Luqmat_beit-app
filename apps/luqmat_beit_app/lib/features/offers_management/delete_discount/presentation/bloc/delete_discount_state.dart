import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_discount_state.freezed.dart';

@freezed
class DeleteDiscountState with _$DeleteDiscountState {
  const factory DeleteDiscountState.initial() = DeleteDiscountInitial;
  const factory DeleteDiscountState.submitting() = DeleteDiscountSubmitting;
  const factory DeleteDiscountState.success(String discountId) = DeleteDiscountSuccess;
  const factory DeleteDiscountState.failure(AppException exception) = DeleteDiscountFailure;
}
