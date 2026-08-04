/// Every failure that crosses the ApiClient boundary becomes one of these.
/// Nothing above this layer should ever need to inspect a DioException,
/// an HTTP status code, or a raw SocketException directly. `sealed` means
/// the compiler forces exhaustive handling anywhere this is switched on.
sealed class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  const AppException(this.message, {this.statusCode, this.cause});

  /// Overridden once, here. Every subtype gets a correct toString() for
  /// free — `Text(exception.toString())` is always safe to write.
  @override
  String toString() => message;
}

/// No response reached the device at all: airplane mode, DNS failure,
/// dropped connection mid-request.
final class NetworkException extends AppException {
  const NetworkException([
    super.message = 'No internet connection. Check your network and try again.',
  ]);
}

/// The request or response took too long.
final class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'The request timed out. Please try again.',
  ]);
}

/// The request was cancelled — e.g. the user navigated away before it
/// finished. Usually safe to ignore silently in the UI.
final class CancelledException extends AppException {
  const CancelledException([super.message = 'Request cancelled.']);
}

/// 400 — malformed request.
final class BadRequestException extends AppException {
  const BadRequestException(super.message, {super.statusCode});
}

/// 401 — missing, expired, or invalid credentials. Kept as its own type
/// (not folded into a generic 4xx) specifically so the app can react
/// globally — force logout — without string-matching a message.
final class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.statusCode});
}

/// 403 — authenticated, but not allowed to do this.
final class ForbiddenException extends AppException {
  const ForbiddenException(super.message, {super.statusCode});
}

/// 404 — resource doesn't exist.
final class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.statusCode});
}

/// 409 — conflicting state (duplicate entry, stale write, etc).
final class ConflictException extends AppException {
  const ConflictException(super.message, {super.statusCode});
}

/// 422 — validation failure. Carries per-field errors when the backend
/// supplies them, so a form can highlight the offending field instead of
/// showing one generic message for every kind of bad input.
final class ValidationException extends AppException {
  final Map<String, List<String>> fieldErrors;
  const ValidationException(
    super.message, {
    this.fieldErrors = const {},
    super.statusCode,
  });
}

/// 5xx — the backend is broken, not the request.
final class ServerErrorException extends AppException {
  const ServerErrorException(super.message, {super.statusCode});
}

/// Anything else: a status code with no explicit case, an unparseable
/// body, a platform exception that isn't even a DioException. Always
/// constructed with the best message available — this is the type that
/// replaces "falls through and returns null."
final class UnknownException extends AppException {
  const UnknownException(super.message, {super.statusCode, super.cause});
}
