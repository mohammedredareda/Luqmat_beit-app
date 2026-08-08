import 'package:core/core.dart';

/// Stands in for a `notifications_remote_data_source.dart` until a backend
/// exists — but unlike the other mock datasources in this app, this one
/// reads/writes `LocalCacheBox.box(LocalCacheBoxNames.notifications)`
/// directly instead of holding state in memory. That's deliberate: the
/// notification-reliability rule (Customer_Cook_Harmonization_Report.md §7)
/// requires notifications to always be visible in-app regardless of push
/// delivery outcome, i.e. DB/cache-primary, push-secondary. Marking a
/// notification read here persists to Hive so it survives app restarts,
/// not just the in-memory Cubit state.
///
/// Each notification is stored as a plain JSON-encodable map (id, type
/// index, title, body, createdAt millis, isRead, deepLinkRoute) — there is
/// no custom Hive TypeAdapter in this project (see local_cache_box.dart).
///
/// TODO(backend): no notification push/sync endpoint exists in the API
/// collection — this stays local-cache-only until one does; per the
/// cache-primary design above, it should likely remain the source of truth
/// even once a remote sync exists.
class NotificationsLocalDataSource {
  Future<List<NotificationEntity>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final box = LocalCacheBox.box(LocalCacheBoxNames.notifications);
    if (box.isEmpty) {
      await _seed(box);
    }
    final notifications = box.values
        .map((raw) => _fromMap(Map<String, dynamic>.from(raw as Map)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notifications;
  }

  Future<void> markAsRead(String notificationId) async {
    final box = LocalCacheBox.box(LocalCacheBoxNames.notifications);
    final raw = box.get(notificationId);
    if (raw == null) return;
    final notification = _fromMap(Map<String, dynamic>.from(raw as Map));
    if (notification.isRead) return;
    await box.put(
      notificationId,
      _toMap(notification.copyWith(isRead: true)),
    );
  }

  Future<void> _seed(dynamic box) async {
    final now = DateTime.now();
    final seed = <NotificationEntity>[
      NotificationEntity(
        id: 'n1',
        type: NotificationType.orderStatus,
        title: 'تغيّرت حالة طلبك',
        body:
            'طلبك رقم #48291 من "مطبخ أم صهيب" في الطريق إليك. تتبع الطلب لمعرفة وقت الوصول المتوقع.',
        createdAt: now,
        deepLinkRoute: '/orders/48291',
      ),
      NotificationEntity(
        id: 'n2',
        type: NotificationType.system,
        title: 'رفضت طباخة جزءاً من طلبك المقسّم',
        body:
            'يمكنك المتابعة بالجزء المقبول من الطلب أو إلغاء الطلب كاملاً واسترداد المبلغ.',
        createdAt: now.subtract(const Duration(hours: 2)),
        deepLinkRoute: '/orders/48277',
      ),
      NotificationEntity(
        id: 'n3',
        type: NotificationType.offer,
        title: 'خصم جديد من أم أحمد!',
        body: 'استمتعي بخصم 20% على جميع أطباق المقبلات هذا الأسبوع فقط.',
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: true,
        deepLinkRoute: '/chef/umm-ahmad',
      ),
      NotificationEntity(
        id: 'n4',
        type: NotificationType.system,
        title: 'مرحباً بك في لُقمة بيت',
        body: 'تصفّح المطابخ المنزلية القريبة منك وابدأ طلبك الأول اليوم.',
        createdAt: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationEntity(
        id: 'n5',
        type: NotificationType.orderStatus,
        title: 'تم تسليم طلبك بنجاح',
        body:
            'نتمنى أن تكوني قد استمتعتِ بوجبتك من "مطبخ الشام". لا تنسي تقييم الطباخة.',
        createdAt: now.subtract(const Duration(days: 3)),
        isRead: true,
        deepLinkRoute: '/orders/48210',
      ),
    ];
    for (final notification in seed) {
      await box.put(notification.id, _toMap(notification));
    }
  }

  Map<String, dynamic> _toMap(NotificationEntity notification) => {
        'id': notification.id,
        'type': notification.type.index,
        'title': notification.title,
        'body': notification.body,
        'createdAt': notification.createdAt.millisecondsSinceEpoch,
        'isRead': notification.isRead,
        'deepLinkRoute': notification.deepLinkRoute,
      };

  NotificationEntity _fromMap(Map<String, dynamic> map) => NotificationEntity(
        id: map['id'] as String,
        type: NotificationType.values[map['type'] as int],
        title: map['title'] as String,
        body: map['body'] as String,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        isRead: map['isRead'] as bool,
        deepLinkRoute: map['deepLinkRoute'] as String?,
      );
}
