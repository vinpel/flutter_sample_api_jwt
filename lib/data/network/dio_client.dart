import 'package:dio/dio.dart';
import 'package:flutter_sample_api_jwt/data/network/api/constant/my_backend_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
// dio instance
  final Dio _dio;
  final storage = const FlutterSecureStorage();
  void addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) =>
          requestInterceptor(options, handler),
    ));
  }

  dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("requiresAccessToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresAccessToken");
      String accessToken = await storage.read(key: "accessToken") as String;
      options.headers.addAll({"Authorization": "Bearer $accessToken"});
      return handler.next(options);
    }

    if (options.headers.containsKey("requiresRefreshToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresRefreshToken");
      String refreshToken = await storage.read(key: "refreshToken") as String;
      options.headers.addAll({"Authorization": "Bearer $refreshToken"});
      return handler.next(options);
    }
    return handler.next(options);
  }

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = MyBackendEndpoints.baseUrl
      ..options.connectTimeout = MyBackendEndpoints.connectionTimeout
      ..options.receiveTimeout = MyBackendEndpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
    addInterceptors();
  }
  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
