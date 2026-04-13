import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Cliente HTTP singleton baseado no Dio.
/// Todas as requisições da aplicação devem passar por aqui.
class HttpClient {
  static final HttpClient _instance = HttpClient._internal();

  late final Dio _dio;

  factory HttpClient() => _instance;

  HttpClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://viacep.com.br/ws',
        connectTimeout: 10000, // Dio 4.x usa milissegundos (int)
        receiveTimeout: 10000,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // Interceptor de log apenas em modo debug
    if (kDebugMode) {
      _dio.interceptors.add(_LoggingInterceptor());
    }
  }

  Dio get dio => _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response;
  }
}

/// Interceptor de logging para ambiente de desenvolvimento.
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[HTTP] --> ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[HTTP] <-- ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('[HTTP] ERR ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
