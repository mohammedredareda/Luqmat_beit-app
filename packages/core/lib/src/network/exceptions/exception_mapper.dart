import 'dart:io';
import 'package:dio/dio.dart';
import 'app_exception.dart';

typedef ErrorMessageExtractor = String? Function(dynamic responseData);

/// The one chokepoint every DioException passes through exactly once
/// (inside DioClient) and comes out as an [AppException].
AppException mapDioException(
  DioException error, {
  ErrorMessageExtractor extractMessage = defaultExtractErrorMessage,
}) {
  final response = error.response;
  final statusCode = response?.statusCode;
  final extracted = response != null ? extractMessage(response.data) : null;

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return TimeoutException(extracted ?? const TimeoutException().message);

    case DioExceptionType.connectionError:
      return NetworkException(extracted ?? const NetworkException().message);

    case DioExceptionType.cancel:
      return CancelledException(extracted ?? const CancelledException().message);

    case DioExceptionType.badCertificate:
      return NetworkException(extracted ?? 'تعذر التحقق من شهادة أمان الخادم.');

    case DioExceptionType.badResponse:
      return _mapStatusCode(statusCode, extracted, response?.data);

    case DioExceptionType.unknown:
      if (error.error is SocketException) {
        return NetworkException(extracted ?? const NetworkException().message);
      }
      return UnknownException(
        extracted ?? error.message ?? 'حدث خطأ ما. حاول مرة أخرى.',
        cause: error.error,
      );
  }
}

AppException _mapStatusCode(int? statusCode, String? message, [dynamic responseData]) {
  final fallback =
      message ?? 'فشل الطلب${statusCode != null ? ' ($statusCode)' : ''}.';
  switch (statusCode) {
    case 400:
      return BadRequestException(fallback, statusCode: statusCode);
    case 401:
      return UnauthorizedException(
        message ?? 'انتهت صلاحية الجلسة. الرجاء تسجيل الدخول مرة أخرى.',
        statusCode: statusCode,
      );
    case 403:
      return ForbiddenException(
        message ?? 'لا تملك صلاحية القيام بذلك.',
        statusCode: statusCode,
      );
    case 404:
      // NestJS's default "no matching route" 404 (`"Cannot GET /a/b/c"`) is
      // an internal routing string, not a user-facing message — showing it
      // verbatim reads like a raw programming error. Fall back to the
      // generic message instead of surfacing it.
      final isRouteNotFoundStub =
          message != null && RegExp(r'^Cannot [A-Z]+ ').hasMatch(message);
      return NotFoundException(
        isRouteNotFoundStub ? 'غير موجود.' : (message ?? 'غير موجود.'),
        statusCode: statusCode,
      );
    case 409:
      return ConflictException(fallback, statusCode: statusCode);
    case 422:
      return ValidationException(
        message ?? 'الرجاء التحقق من النموذج والمحاولة مرة أخرى.',
        fieldErrors: extractFieldErrors(responseData),
        statusCode: statusCode,
      );
    case 500:
    case 502:
    case 503:
    case 504:
      return ServerErrorException(
        message ?? 'واجه الخادم مشكلة. حاول مرة أخرى بعد قليل.',
        statusCode: statusCode,
      );
    default:
      return UnknownException(fallback, statusCode: statusCode);
  }
}

String? defaultExtractErrorMessage(dynamic data) {
  if (data == null) return null;
  if (data is String && data.trim().isNotEmpty) return data;

  if (data is Map) {
    final message = data['message'];
    if (message is String && message.isNotEmpty) return message;
    if (message is List && message.isNotEmpty) {
      return message.map((e) => e.toString()).join('\n');
    }

    final error = data['error'];
    if (error is String && error.isNotEmpty) return error;
    if (error is Map && error['message'] is String) {
      return error['message'] as String;
    }

    final detail = data['detail'];
    if (detail is String && detail.isNotEmpty) return detail;

    final title = data['title'];
    if (title is String && title.isNotEmpty) return title;

    final errors = data['errors'];
    if (errors is Map) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first as String;
        }
      }
    }
    if (errors is List && errors.isNotEmpty && errors.first is String) {
      return errors.first as String;
    }
  }
  return null;
}

Map<String, List<String>> extractFieldErrors(dynamic data) {
  if (data is! Map) return const {};
  final errors = data['errors'];
  if (errors is! Map) return const {};
  return errors.map(
    (key, value) => MapEntry(
      key.toString(),
      value is List ? value.map((e) => e.toString()).toList() : [value.toString()],
    ),
  );
}
