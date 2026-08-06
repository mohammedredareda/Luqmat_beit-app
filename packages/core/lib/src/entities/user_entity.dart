import 'package:equatable/equatable.dart';

enum UserRole { customer, cook }

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String? avatarUrl;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, phone, avatarUrl, role];
}
