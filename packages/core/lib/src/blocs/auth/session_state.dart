import 'package:equatable/equatable.dart';

import '../../entities/user_entity.dart';

/// [role] is only meaningful when [isAuthenticated] is true — it's derived
/// from the session token's own `role` claim, never asked for separately.
class SessionState extends Equatable {
  const SessionState({required this.isAuthenticated, this.role});

  static const unauthenticated = SessionState(isAuthenticated: false);

  final bool isAuthenticated;
  final UserRole? role;

  @override
  List<Object?> get props => [isAuthenticated, role];
}
