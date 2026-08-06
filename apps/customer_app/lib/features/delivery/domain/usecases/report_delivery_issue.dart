import 'package:core/core.dart';

import '../repositories/delivery_repository.dart';

class ReportDeliveryIssue {
  const ReportDeliveryIssue(this._repository);

  final DeliveryRepository _repository;

  Future<Result<void>> call(String orderId, String reason) =>
      _repository.reportIssue(orderId, reason);
}
