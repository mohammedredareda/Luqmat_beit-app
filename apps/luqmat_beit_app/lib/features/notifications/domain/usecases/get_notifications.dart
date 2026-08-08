import 'package:core/core.dart';

import '../repositories/notifications_repository.dart';

class GetNotifications {
  const GetNotifications(this._repository);

  final NotificationsRepository _repository;

  Future<Result<List<NotificationEntity>>> call() =>
      _repository.getNotifications();
}
