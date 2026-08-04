import 'package:dio/dio.dart';

/// Retries idempotent requests (`GET` by default) with exponential backoff
/// when they fail due to a timeout or dropped connection — the class of
/// failure that's often transient on mobile networks. Never retries
/// `POST`/`PATCH`/`DELETE` by default, since those aren't safe to repeat
/// blindly unless the backend guarantees idempotency (e.g. via an
/// idempotency key). Not wired into any client by default — opt in per
/// [DioClient] only where genuinely needed.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;
  final Set<String> retryableMethods;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 500),
    this.retryableMethods = const {'GET'},
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final method = err.requestOptions.method.toUpperCase();
    final isTransient = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
    final attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;

    if (isTransient && retryableMethods.contains(method) && attempt < maxRetries) {
      final nextAttempt = attempt + 1;
      await Future.delayed(baseDelay * nextAttempt);
      try {
        final options = err.requestOptions..extra['retry_attempt'] = nextAttempt;
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } catch (_) {
        // fall through and propagate the original error
      }
    }
    handler.next(err);
  }
}
