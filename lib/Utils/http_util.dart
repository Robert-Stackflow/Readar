import 'dart:io';

import 'package:cloudreader/Utils/iprint.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpUtil {
  static HttpUtil instance = HttpUtil();
  late Dio dio;
  late BaseOptions options;
  String baseUrl = "";
  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    return instance;
  }

  HttpUtil() {
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
        (X509Certificate? cert, String host, int port) => true;
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      return handler.next(e);
    }));
  }

  static get(url, {data, options, cancelToken, bool useBase = true}) async {
    return getInstance()
        ._get(url, data: data, options: options, cancelToken: cancelToken);
  }

  static post(url, {data, options, cancelToken}) async {
    return getInstance()
        ._post(url, data: data, options: options, cancelToken: cancelToken);
  }

  _get(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      // IPrint.debug('[Get] [Success] [$url] : ${response.data}');
    } on DioException catch (e) {
      formatError(url, e);
    }
    return response?.data['data'];
  }

  _post(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await dio.post(url,
          data: data, options: options, cancelToken: cancelToken);
      // IPrint.debug('[Post] [Success] [$url] : ${response.data}');
    } on DioException catch (e) {
      formatError(url, e);
    }
    if (response?.data['code'] == 1002 ||
        response?.data['code'] == 1003 ||
        response?.data['code'] == 1004) {
      return response?.data['message'];
    } else {
      return response?.data['data'];
    }
  }

  void formatError(String url, DioException e) {
    IPrint.debug("${e.response}");
    if (e.type == DioExceptionType.connectionTimeout) {
      IPrint.debug("$url:连接超时");
    } else if (e.type == DioExceptionType.sendTimeout) {
      IPrint.debug("$url:请求超时");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      IPrint.debug("$url:响应超时");
    } else if (e.type == DioExceptionType.badResponse) {
      IPrint.debug("$url:出现异常");
    } else if (e.type == DioExceptionType.cancel) {
      IPrint.debug("$url:请求取消");
    } else {
      IPrint.debug("$url:未知错误");
    }
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
