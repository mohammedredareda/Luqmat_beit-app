/// Every failure that crosses the ApiClient boundary becomes one of these.
/// `sealed` forces exhaustive handling anywhere this is switched on.
sealed class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  const AppException(this.message, {this.statusCode, this.cause});

  @override
  String toString() => message;
}

final class NetworkException extends AppException {
  const NetworkException([
    super.message = 'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.',
  ]);
}

final class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'انتهت مهلة الطلب. حاول مرة أخرى.',
  ]);
}

final class CancelledException extends AppException {
  const CancelledException([super.message = 'تم إلغاء الطلب.']);
}

final class BadRequestException extends AppException {
  const BadRequestException(super.message, {super.statusCode});
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.statusCode});
}

final class ForbiddenException extends AppException {
  const ForbiddenException(super.message, {super.statusCode});
}

final class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.statusCode});
}

final class ConflictException extends AppException {
  const ConflictException(super.message, {super.statusCode});
}

final class ValidationException extends AppException {
  final Map<String, List<String>> fieldErrors;
  const ValidationException(
    super.message, {
    this.fieldErrors = const {},
    super.statusCode,
  });
}

final class ServerErrorException extends AppException {
  const ServerErrorException(super.message, {super.statusCode});
}

final class UnknownException extends AppException {
  const UnknownException(super.message, {super.statusCode, super.cause});
}

/// Device location permission denied or location services disabled —
/// distinguished from a generic failure so the UI can offer an
/// "open settings" action instead of a plain retry.
final class LocationPermissionDeniedException extends AppException {
  const LocationPermissionDeniedException([
    super.message = 'يرجى السماح بالوصول لموقعك من إعدادات الجهاز لتحديد عنوانك تلقائياً.',
  ]);
}
