import 'package:core/core.dart';

abstract class NotificationsRepository {
  Future<Result<List<NotificationEntity>>> getNotifications();

  Future<Result<void>> markAsRead(String notificationId);
}
