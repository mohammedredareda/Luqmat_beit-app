import 'package:dio/dio.dart';

/// Thin wrapper around Dio's LogInterceptor so logging can be switched
/// off in release builds from the construction site
/// (`LoggingInterceptor(enabled: kDebugMode)`) instead of conditionally
/// adding/removing the interceptor elsewhere.
class LoggingInterceptor extends LogInterceptor {
  LoggingInterceptor({bool enabled = true})
      : super(
          request: enabled,
          requestHeader: enabled,
          requestBody: enabled,
          responseHeader: false,
          responseBody: enabled,
          error: enabled,
        );
}
