import 'dart:io';

import 'package:base_app/base_app.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'locator/get_it.dart';

const DEFAULT_CACHE_DURATION = 7;

class BaseRequestNew {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options.baseUrl = 'https://api.covid19api.com';
    dio.options.connectTimeout = cRequestTimeOut;
    dio.options.receiveTimeout = cRequestTimeOut;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  Future<dynamic> sendRequest(String action, RequestMethod requestMethod,
      {Map<String, String> jsonMap, bool buildCacheOptions = false}) async {
    Response response;

    if (buildCacheOptions) {
      dio.interceptors.add(GetIt.I<DioCacheManager>().interceptor);
    }

    Map<String, String> headers = await getBaseHeader(requestMethod.toString());
    Options options = Options(
        headers: headers,
        method: requestMethod.toString(),
        responseType: ResponseType.json);

    if (requestMethod == RequestMethod.POST) {
      response = await dio.post(action, data: jsonMap, options: options);
    } else if (requestMethod == RequestMethod.GET) {
      response =
          await dio.get(action, queryParameters: jsonMap, options: options);
    }
    return response.data;
  }

  Future<Map<String, String>> getBaseHeader(String httpMethod) async {
    return {
      "Content-Type": "application/json",
      'Admin-Agent': 'iinvoice.vn',
    };
  }
}
