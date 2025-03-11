import 'dart:convert';
import 'package:app_logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'injection.dart';
import 'configuration.dart';

@module
abstract class InjectableModule {

  @lazySingleton
  Dio get dioInstance {

    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',

          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );

    // dio.httpClientAdapter = IOHttpClientAdapter();

    dio.options.baseUrl = getIt<Configuration>().getBaseUrl;

    // Set the NTLM authentication credentials
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     // options.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode('inspector1:Abc12345'))}';
    //     return handler.next(options);
    //   },
    // ));


    dio.interceptors.add(
      kDebugMode? LogInterceptor(
        responseBody: false,
        requestBody: true,
        request: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
        logPrint: (obj) {
          debugPrint(obj.toString());
        },
      ):LogInterceptor(
        responseBody: false,
        requestBody: false,
        request: false,
        requestHeader: false,
        error: false,
        responseHeader: false,
        logPrint: (obj) {
          // debugPrint(obj.toString());
        },
      ),
    );

    dio.interceptors.add(CustomInterceptors());


    return dio;
  }

  @lazySingleton
  Logger get logger => Logger();
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  AppLogger.it.logTrace(
        'REQUEST[${options.method}] => PATH: ${options.path}  ${options.data != null ? "data => ${jsonEncode(options.data)}" : ''}  ${options.queryParameters.isNotEmpty ? "queryParameters => ${options.queryParameters}" : ''}');
  AppLogger.it.logDeveloper(
        'REQUEST[${options.method}] => PATH: ${options.path}  ${options.data != null ? "data => ${jsonEncode(options.data)}" : ''}  ${options.queryParameters.isNotEmpty ? "queryParameters => ${options.queryParameters}" : ''}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.it.logInfo(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} [Content-Type]=${response.headers['Content-Type']}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    AppLogger.it.logError(
        'ERROR[${err.response?.statusCode}] [${err.response}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}