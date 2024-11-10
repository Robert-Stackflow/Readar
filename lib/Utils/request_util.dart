import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:readar/Utils/file_util.dart';
import 'package:readar/Utils/ilogger.dart';
import 'package:readar/Utils/iprint.dart';

enum DomainType { api }

class RequestUtil {
  static RequestUtil instance = RequestUtil();
  late Dio dio;
  late BaseOptions options;
  static CookieJar? cookieJar;
  static CookieManager? cookieManager;
  static const String apiUrl = "https://api.cloudchewie.com";

  static RequestUtil getInstance({DomainType domainType = DomainType.api}) {
    switch (domainType) {
      case DomainType.api:
        return instance;
    }
  }

  static init() async {
    cookieJar = PersistCookieJar(
      storage: FileStorage(await FileUtil.getCookiesDir()),
    );
    cookieManager = CookieManager(cookieJar!);
  }

  static Future<String?> getCookie(String key) async {
    return await cookieJar?.loadForRequest(Uri.parse(apiUrl)).then((value) {
      try {
        return value.firstWhere((element) => element.name == key).value;
      } catch (e) {
        return null;
      }
    });
  }

  static Future<Map> getCookies() async {
    List<Cookie>? cookies = await cookieJar?.loadForRequest(Uri.parse(apiUrl));
    Map<String, String> cookieMap = {};
    cookies?.forEach((cookie) {
      cookieMap[cookie.name] = cookie.value;
    });
    return cookieMap;
  }

  RequestUtil({DomainType domainType = DomainType.api}) {
    String baseURL = "";
    switch (domainType) {
      case DomainType.api:
        baseURL = apiUrl;
        break;
    }
    options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 25),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
        (X509Certificate? cert, String host, int port) => true;
    dio.interceptors.add(cookieManager!);
  }

  static Future<void> clearCookie() async {
    cookieJar?.deleteAll();
  }

  Future<Response?> _get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    DomainType? domainType,
    bool forceCsrfToken = false,
  }) async {
    Response? response;
    options = await _preProcessRequest(
      options: options,
      domainType: domainType,
    );
    try {
      response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      _printResponse(response);
      _preProcessResponse(response);
    } on DioException catch (e) {
      _printError(e);
      _preProcessResponse(e.response);
      rethrow;
    }
    return response;
  }

  Future<Response?> _post(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Options? options,
    DomainType? domainType,
    bool stream = false,
    List<int>? streamData,
  }) async {
    Response? response;
    options = await _preProcessRequest(
      options: options,
      domainType: domainType,
    );
    try {
      response = await dio.post(
        url,
        queryParameters: params,
        data: stream && streamData != null
            ? Stream.fromIterable(streamData.map((e) => [e]))
            : data,
        options: options,
      );
      _printResponse(response);
      _preProcessResponse(response);
    } on DioException catch (e) {
      _printError(e);
      _preProcessResponse(e.response);
      rethrow;
    }
    return response;
  }

  static _preProcessResponse(Response? response) async {}

  _preProcessRequest({
    Options? options,
    DomainType? domainType,
  }) async {
    options = options ?? Options();
    options.headers ??= {};
    return options;
  }

  _printResponse(Response response) {
    Map<String, Object?> list = {
      "URL": response.requestOptions.uri,
    };
    if (response.requestOptions.headers['lofter-phone-login-auth'] != null) {
      list['Lofter-phone-login-auth'] =
          response.requestOptions.headers['lofter-phone-login-auth'] != null
              ? "有"
              : "无";
    }
    list["Cookie"] =
        response.requestOptions.headers['cookie'] != null ? "有" : "无";
    list["Content-Length"] = response.requestOptions.headers['Content-Length'];
    list["Content-Type"] = response.requestOptions.contentType;
    if (response.requestOptions.headers['authorization'] != null) {
      list['Authorization'] =
          response.requestOptions.headers['authorization'] != null ? "有" : "无";
    }
    if (response.requestOptions.method == "POST" &&
        response.requestOptions.data != null) {
      list['Request Body'] = response.requestOptions.data;
    }
    if (response.data is Map<dynamic, dynamic>) {
      list['Data'] = response.data;
    }
    IPrint.format(
      tag: response.requestOptions.method,
      status: "Success",
      list: list,
    );
  }

  static Future<Response?> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    DomainType domainType = DomainType.api,
    bool forceCsrfToken = false,
  }) async {
    return getInstance(domainType: domainType)._get(
      url,
      params: params,
      options: options,
      domainType: domainType,
      forceCsrfToken: forceCsrfToken,
    );
  }

  static Future<Response?> post(
    url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Options? options,
    DomainType domainType = DomainType.api,
    bool stream = false,
    List<int>? streamData,
  }) async {
    return getInstance(domainType: domainType)._post(
      url,
      params: params,
      data: data,
      options: options,
      stream: stream,
      streamData: streamData,
      domainType: domainType,
    );
  }

  void _printError(DioException e) {
    String info =
        '[${e.requestOptions.method}] [${e.requestOptions.uri}] [${e.requestOptions.headers}] [${e.response?.statusCode}] [${e.response?.data}]';
    if (e.type == DioExceptionType.connectionTimeout) {
      ILogger.error("DioException", "$info: 连接超时");
    } else if (e.type == DioExceptionType.sendTimeout) {
      ILogger.error("DioException", "$info: 请求超时");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      ILogger.error("DioException", "$info: 响应超时");
    } else if (e.type == DioExceptionType.badResponse) {
      ILogger.error("DioException", "$info: 出现异常");
    } else if (e.type == DioExceptionType.cancel) {
      ILogger.error("DioException", "$info: 请求取消");
    } else {
      ILogger.error("DioException", "$info: $e");
    }
  }
}
