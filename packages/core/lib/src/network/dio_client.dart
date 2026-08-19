import 'package:dio/dio.dart';

import 'api_client.dart';
import 'exceptions/exception_mapper.dart';

/// Dio-based implementation of [ApiClient]. Every verb routes through
/// [_run], so error-mapping can't be forgotten on one verb while present
/// on the others.
class DioClient implements ApiClient {
  final Dio dio;
  final ErrorMessageExtractor extractErrorMessage;

  DioClient({
    required this.dio,
    required String baseUrl,
    List<Interceptor> interceptors = const [],
    this.extractErrorMessage = defaultExtractErrorMessage,
    Duration connectTimeout = const Duration(seconds: 60),
    Duration receiveTimeout = const Duration(seconds: 60),
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    dio.interceptors.addAll(interceptors);
  }

  Future<dynamic> _run(Future<Response<dynamic>> Function() call) async {
    try {
      final response = await call();
      return response.data;
    } on DioException catch (e) {
      throw mapDioException(e, extractMessage: extractErrorMessage);
    }
  }

  Options? _options(Map<String, dynamic>? headers) =>
      headers != null ? Options(headers: headers) : null;

  Object? _body(Object? data, bool isFormData) =>
      isFormData && data is Map ? FormData.fromMap(data.cast<String, dynamic>()) : data;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _run(() => dio.get(path,
          queryParameters: queryParameters, options: _options(headers)));

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) =>
      _run(() => dio.post(path,
          data: _body(data, isFormData),
          queryParameters: queryParameters,
          options: _options(headers)));

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) =>
      _run(() => dio.put(path,
          data: _body(data, isFormData),
          queryParameters: queryParameters,
          options: _options(headers)));

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) =>
      _run(() => dio.patch(path,
          data: _body(data, isFormData),
          queryParameters: queryParameters,
          options: _options(headers)));

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _run(() => dio.delete(path,
          data: data, queryParameters: queryParameters, options: _options(headers)));

  @override
  String? resolveAssetUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    final base = dio.options.baseUrl;
    if (base.isEmpty) return path;
    return path.startsWith('/') ? '$base$path' : '$base/$path';
  }
}
