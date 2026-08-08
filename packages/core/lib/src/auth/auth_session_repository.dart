import '../entities/user_entity.dart';
import '../network/result.dart';
import 'otp_purpose.dart';

/// Login, OTP verify/resend, and password reset — byte-identical between
/// customer and cook (same endpoints, same payload shape), unlike
/// registration, which each app implements itself since the required
/// fields genuinely differ per role.
abstract class AuthSessionRepository {
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
