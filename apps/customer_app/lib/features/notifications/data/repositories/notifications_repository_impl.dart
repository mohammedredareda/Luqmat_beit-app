import 'package:core/core.dart';

import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_local_data_source.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({NotificationsLocalDataSource? dataSource})
      : _dataSource = dataSource ?? NotificationsLocalDataSource();

  final NotificationsLocalDataSource _dataSource;

  @override
  Future<Result<List<NotificationEntity>>> getNotifications() {
    return guard(() => _dataSource.getNotifications());
  }

  @override
  Future<Result<void>> markAsRead(String notificationId) {
    return guard(() => _dataSource.markAsRead(notificationId));
  }
}
