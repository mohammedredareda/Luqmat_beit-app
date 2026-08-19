/// Abstract transport boundary. Repositories depend on this, never on
/// the underlying HTTP client directly — that's what makes repositories
/// testable with a fake, and what lets Dio be swapped later without
/// touching a single feature.
abstract class ApiClient {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Resolves a possibly host-relative asset path (e.g. `/uploads/x.png`,
  /// as `/users/profile`'s `image` field comes back) into an absolute URL
  /// `Image.network` can load — most endpoints already return a full URL,
  /// but callers can't tell which shape they'll get without this, so every
  /// datasource that reads an image/avatar field should route it through
  /// here rather than trusting the backend's field verbatim.
  String? resolveAssetUrl(String? path);
}
