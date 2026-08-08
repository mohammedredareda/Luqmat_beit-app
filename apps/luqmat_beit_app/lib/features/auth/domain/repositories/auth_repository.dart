import 'package:core/core.dart';

export 'package:core/core.dart' show OtpPurpose;

/// CU-01/CK-01 — registration, login, OTP verification and password
/// recovery. `login`/`requestOtp`/`verifyOtp`/`resetPassword` are
/// role-agnostic, delegating to core's shared `AuthSessionRepository`.
/// `register` is the one method both roles share the *shape* of but not
/// the full field set — [description] and [availabilityDuration] only
/// apply when [role] is `UserRole.cook` (enforced by `RegistrationCubit`,
/// which is also the only place that decides whether they're required,
/// since one shared form toggles between roles at runtime).
abstract class AuthRepository {
  Future<Result<void>> register({
    required UserRole role,
    required String name,
    required String phone,
    required String password,
    required String address,
    String? description,
    String? availabilityDuration,
    double? latitude,
    double? longitude,
  });

  Future<Result<UserEntity>> login({
    required String phone,
    required String password,
  });

  /// Sends (or resends) a one-time code to [phone]. Used both right after
  /// registration and as the first step of the forgot-password flow.
  Future<Result<void>> requestOtp(
    String phone, {
    OtpPurpose purpose = OtpPurpose.registration,
  });

  Future<Result<void>> verifyOtp({
    required String phone,
    required String code,
    OtpPurpose purpose = OtpPurpose.registration,
  });

  Future<Result<void>> resetPassword({
    required String phone,
    required String newPassword,
  });
}
