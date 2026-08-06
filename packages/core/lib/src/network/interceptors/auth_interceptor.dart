import 'package:dio/dio.dart';

typedef TokenProvider = Future<String?> Function();
typedef UnauthorizedHandler = Future<void> Function();

/// Attaches a bearer token to every outgoing request via an injected
/// [TokenProvider]. Optionally reacts to a global 401 once (e.g. clear the
/// session and route to login) instead of leaving every feature to notice.
class AuthInterceptor extends Interceptor {
  final TokenProvider getToken;
  final UnauthorizedHandler? onUnauthorized;

  AuthInterceptor({required this.getToken, this.onUnauthorized});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
    }
    handler.next(err);
  }
}
