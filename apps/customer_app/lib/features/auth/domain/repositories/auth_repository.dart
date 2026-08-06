import 'package:core/core.dart';

/// Distinguishes the two flows that both send/verify a one-time code —
/// the backend exposes them as separate endpoints (`/auth/verify/resend`
/// vs `/auth/forget-password`), even though the client-side shape is
/// identical.
enum OtpPurpose { registration, passwordReset }

/// CU-01–CU-04 — registration, login, OTP verification and password
/// recovery. Every method here is backed by a mock datasource today (no
/// backend yet) — the interface is written against what a real API would
/// expose, so swapping in `AuthRemoteDataSource` later is a one-file change.
abstract class AuthRepository {
  Future<Result<void>> registerCustomer({
    required String fullName,
    required String phone,
    required String password,
    required String address,
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
