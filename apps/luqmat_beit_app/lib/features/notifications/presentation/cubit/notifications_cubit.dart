import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_as_read.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotifications, this._markNotificationAsRead)
      : super(const NotificationsState.initial());

  final GetNotifications _getNotifications;
  final MarkNotificationAsRead _markNotificationAsRead;

  Future<void> load() async {
    emit(const NotificationsState.loading());
    final result = await _getNotifications();
    result.fold(
      (notifications) => emit(NotificationsState.loaded(notifications)),
      (exception) => emit(NotificationsState.failure(exception)),
    );
  }

  void selectTab(NotificationsTab tab) {
    final current = state;
    if (current is NotificationsLoaded) {
      emit(NotificationsState.loaded(current.notifications, selectedTab: tab));
    }
  }

  /// Optimistically flips the tile to read so the tap feels instant; the
  /// datasource persists the same change to the Hive box underneath, so the
  /// read state survives even if this in-memory update were ever lost.
  Future<void> markAsRead(String notificationId) async {
    final current = state;
    if (current is! NotificationsLoaded) return;

    final alreadyRead = current.notifications
        .firstWhere((n) => n.id == notificationId)
        .isRead;
    if (alreadyRead) return;

    final updated = [
      for (final notification in current.notifications)
        if (notification.id == notificationId)
          notification.copyWith(isRead: true)
        else
          notification,
    ];
    emit(NotificationsState.loaded(updated, selectedTab: current.selectedTab));
    await _markNotificationAsRead(notificationId);
  }
}
