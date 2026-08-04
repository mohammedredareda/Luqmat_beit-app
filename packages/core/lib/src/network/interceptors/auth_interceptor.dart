import 'package:dio/dio.dart';

typedef TokenProvider = Future<String?> Function();
typedef UnauthorizedHandler = Future<void> Function();

/// Attaches a bearer token to every outgoing request via an injected
/// [TokenProvider] — deliberately not coupled to any specific storage
/// package, so this file stays identical regardless of where the token
/// actually lives.
///
/// Optionally reacts to a global 401 by invoking [onUnauthorized] once
/// (e.g. clear the session and route to login) instead of leaving every
/// feature to notice and handle a 401 independently.
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
