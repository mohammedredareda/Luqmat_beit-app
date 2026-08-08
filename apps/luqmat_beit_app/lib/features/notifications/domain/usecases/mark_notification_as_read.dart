import 'package:core/core.dart';

import '../repositories/notifications_repository.dart';

class MarkNotificationAsRead {
  const MarkNotificationAsRead(this._repository);

  final NotificationsRepository _repository;

  Future<Result<void>> call(String notificationId) =>
      _repository.markAsRead(notificationId);
}
