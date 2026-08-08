/// Distinguishes the two flows that both send/verify a one-time code —
/// the backend exposes them as separate endpoints (`/auth/verify/resend`
/// vs `/auth/forget-password`), even though the client-side shape is
/// identical.
enum OtpPurpose { registration, passwordReset }
