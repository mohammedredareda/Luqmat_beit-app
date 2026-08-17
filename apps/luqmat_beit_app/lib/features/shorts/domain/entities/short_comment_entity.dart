import 'package:equatable/equatable.dart';

/// One comment on a short, from `GET /user/customer/content/:id/comments`.
class ShortCommentEntity extends Equatable {
  final String id;
  final String text;
  final String customerName;
  final String? customerAvatarUrl;
  final DateTime createdAt;

  const ShortCommentEntity({
    required this.id,
    required this.text,
    required this.customerName,
    required this.createdAt,
    this.customerAvatarUrl,
  });

  @override
  List<Object?> get props => [id, text, customerName, customerAvatarUrl, createdAt];
}
