import 'dart:io';
import 'package:dio/dio.dart';
import 'app_exception.dart';

/// Backend-specific: given a decoded error response body, pull out a
/// human-readable message, or return null if this parser doesn't
/// recognize the shape. This is the one seam to replace per backend —
/// see the default implementation below for the shapes it already covers.
typedef ErrorMessageExtractor = String? Function(dynamic responseData);

/// The one chokepoint: every DioException in the app passes through here
/// exactly once (inside DioClient) and comes out as an [AppException].
/// No other code should call this directly.
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
      return NetworkException(
        extracted ?? "Could not verify the server's security certificate.",
      );

    case DioExceptionType.badResponse:
      return _mapStatusCode(statusCode, extracted);

    case DioExceptionType.unknown:
      // DioExceptionType.unknown wraps platform-level failures Dio didn't
      // classify itself — a dropped socket is the most common cause.
      if (error.error is SocketException) {
        return NetworkException(extracted ?? const NetworkException().message);
      }
      return UnknownException(
        extracted ?? error.message ?? 'Something went wrong. Please try again.',
        cause: error.error,
      );
  }
}

AppException _mapStatusCode(int? statusCode, String? message) {
  final fallback =
      message ?? 'Request failed${statusCode != null ? ' ($statusCode)' : ''}.';
  switch (statusCode) {
    case 400:
      return BadRequestException(fallback, statusCode: statusCode);
    case 401:
      return UnauthorizedException(
        message ?? 'Your session has expired. Please sign in again.',
        statusCode: statusCode,
      );
    case 403:
      return ForbiddenException(
        message ?? "You don't have permission to do that.",
        statusCode: statusCode,
      );
    case 404:
      return NotFoundException(message ?? 'Not found.', statusCode: statusCode);
    case 409:
      return ConflictException(fallback, statusCode: statusCode);
    case 422:
      return ValidationException(
        message ?? 'Please check the form and try again.',
        statusCode: statusCode,
      );
    case 500:
    case 502:
    case 503:
    case 504:
      return ServerErrorException(
        message ?? 'The server ran into a problem. Please try again shortly.',
        statusCode: statusCode,
      );
    default:
      // Deliberately not omitted: any status this switch doesn't name
      // yet still becomes a well-formed exception instead of falling
      // through to a null return.
      return UnknownException(fallback, statusCode: statusCode);
  }
}

/// Default parser: tries the response shapes seen most often across REST
/// APIs, in order, before giving up. Override by passing a custom
/// [ErrorMessageExtractor] into [DioClient] — that's the only thing that
/// changes when this layer points at a different backend.
String? defaultExtractErrorMessage(dynamic data) {
  if (data == null) return null;
  if (data is String && data.trim().isNotEmpty) return data;

  if (data is Map) {
    // { "message": "..." }                 — Laravel, most hand-rolled REST APIs
    final message = data['message'];
    if (message is String && message.isNotEmpty) return message;

    // { "error": "..." } or { "error": { "message": "..." } }
    final error = data['error'];
    if (error is String && error.isNotEmpty) return error;
    if (error is Map && error['message'] is String) {
      return error['message'] as String;
    }

    // { "detail": "..." }                   — Django REST Framework
    final detail = data['detail'];
    if (detail is String && detail.isNotEmpty) return detail;

    // { "title": "..." }                    — RFC 7807 problem+json
    final title = data['title'];
    if (title is String && title.isNotEmpty) return title;

    // { "errors": { "email": ["..."] } }    — Laravel-style validation
    final errors = data['errors'];
    if (errors is Map) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first as String;
        }
      }
    }
    // { "errors": ["..."] }
    if (errors is List && errors.isNotEmpty && errors.first is String) {
      return errors.first as String;
    }
  }
  return null;
}

/// Extracts per-field validation errors from the common
/// `{ "errors": { "field": ["msg1", "msg2"] } }` shape, for
/// [ValidationException.fieldErrors]. Pair with a custom
/// [defaultExtractErrorMessage] override if the backend shapes 422s
/// differently.
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
