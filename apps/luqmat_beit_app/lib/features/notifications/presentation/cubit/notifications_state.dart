import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

/// Which of the two tabs from the mockup ("إشعاراتي" / "إشعارات النظام")
/// is active. System notifications are [NotificationType.system]; the
/// personal tab covers everything else (order-status updates, offers).
enum NotificationsTab { personal, system }

/// Single fetch-and-display flow (CU-24) with a mark-as-read side effect,
/// no UI-distinct branching flows — hence a Cubit, not a Bloc.
@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = NotificationsInitial;
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.loaded(
    List<NotificationEntity> notifications, {
    @Default(NotificationsTab.personal) NotificationsTab selectedTab,
  }) = NotificationsLoaded;
  const factory NotificationsState.failure(AppException exception) =
      NotificationsFailure;
}
