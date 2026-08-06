import 'package:equatable/equatable.dart';

enum NotificationType { orderStatus, offer, system }

/// Notifications are DB-primary/Push-secondary — this entity is what gets
/// cached locally so a notification is always visible in-app regardless of
/// push delivery outcome (Customer_Cook_Harmonization_Report.md §7).
class NotificationEntity extends Equatable {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String? deepLinkRoute;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.deepLinkRoute,
  });

  NotificationEntity copyWith({bool? isRead}) => NotificationEntity(
        id: id,
        type: type,
        title: title,
        body: body,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
        deepLinkRoute: deepLinkRoute,
      );

  @override
  List<Object?> get props =>
      [id, type, title, body, createdAt, isRead, deepLinkRoute];
}
