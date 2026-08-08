import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/delete_discount.dart';
import 'delete_discount_state.dart';

/// CK-15 Delete Discount. A single linear confirm-then-mutate flow,
/// mirroring `DeleteOfferCubit`.
class DeleteDiscountCubit extends Cubit<DeleteDiscountState> {
  DeleteDiscountCubit(this._deleteDiscount) : super(const DeleteDiscountState.initial());

  final DeleteDiscount _deleteDiscount;

  Future<void> delete(String discountId) async {
    emit(const DeleteDiscountState.submitting());
    final result = await _deleteDiscount(discountId);
    result.fold(
      (_) => emit(DeleteDiscountState.success(discountId)),
      (exception) => emit(DeleteDiscountState.failure(exception)),
    );
  }
}
