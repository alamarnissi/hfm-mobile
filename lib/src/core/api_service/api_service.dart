import 'package:tiwee/src/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:tiwee/src/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:tiwee/src/core/injectable/injection.dart';
import 'package:dio/dio.dart';

enum HttpMethodEnum { get, post, put, delete, patch, options }

class ApiService {
  final Dio _dio = tiweeGetIt<Dio>();

  ApiService(
      {String? baseUrl,
        int? connectTimeoutSeconds,
        int? receiveTimeoutSeconds,
        Map<String, String>? headers}) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
    if (connectTimeoutSeconds != null) {
      _dio.options.connectTimeout =
          Duration(seconds: connectTimeoutSeconds); // Connection timeout
    }
    if (receiveTimeoutSeconds != null) {
      _dio.options.receiveTimeout =
          Duration(seconds: receiveTimeoutSeconds); // Receive timeout
    }
    if (headers != null) {
      _dio.options.headers = headers;
    }
  }

  // Generic request method
  Future<ApiResultModel<dynamic>> request<T extends BaseDataModel>({
    required String path,
    required HttpMethodEnum method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    required T
    model, // Model With Custom parser function to handle the response,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.request(path,
          queryParameters: queryParameters,
          data: data,
          options: options ??
              Options(
                method: method.name,
                headers: headers,
              ),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken);

      if (response.data is List<dynamic>) {
        // List<T> responseMap= (response.data??[]).map<T>((item)=> model.parser(item)).toList();
        List<BaseDataModel> responseMap = [];
        for (var item in response.data ?? []) {
          responseMap.add(model.parser(item));
        }
        return ApiResultModel.success(data: responseMap);
      } else {
        return ApiResultModel.success(data: model.parser(response.data));
      }
    } on DioError catch (e) {
      // Handle DioError (network or server-related errors)

      if (e.response != null) {
        // Received a response but something went wrong
        return ApiResultModel.failure(
            errorResultEntity: ErrorResultModel(
              message: 'Error: ${e.response?.data}',
              statusCode: e.response?.statusCode,
            ));
      } else {
        // No response received (timeout, connection issues, etc.)
        // throw Exception('Connection Error: ${e.message}');
        return ApiResultModel.failure(
            errorResultEntity: ErrorResultModel(
              message: 'Connection Error: ${e.message}',
              statusCode: 400,
            ));
      }
    } catch (e) {
      // throw Exception('Unexpected Error: $e');
      return ApiResultModel.failure(
          errorResultEntity: ErrorResultModel(
            message: 'Unexpected Error: $e',
            statusCode: 400,
          ));
    }
  }
}

abstract class BaseDataModel {
  BaseDataModel parser(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
