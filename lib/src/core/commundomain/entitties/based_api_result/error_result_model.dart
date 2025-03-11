import 'package:app_logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'api_result_model.dart';

class ErrorResultModel<T> extends Equatable {
  const ErrorResultModel({
    this.statusCode,
    this.message,
    this.localModel,
    this.localModelId,
  });

  final int? statusCode;
  final String? message;
  final T? localModel;
  final BigInt? localModelId;

  ErrorResultModel copyWith(
      {
        int? nStatusCode,
        String? nMessage,
        T? nLocalModel,
        BigInt? nLocalModelId,
      }
      )=> ErrorResultModel(
        statusCode: nStatusCode ?? statusCode,
        localModelId: nLocalModelId ?? localModelId,
        message: nMessage??message,
        localModel: nLocalModel??localModel
    );

  @override
  List<Object?> get props => <Object?>[
    statusCode,
    message,
    localModelId,
    localModel,
  ];
}

ApiResultModel<T> handleCatch<T>(Object e) {
  AppLogger.it.logError("handleCatch $e");
  if (e is DioError) {
    return ApiResultModel<T>.failure(
      errorResultEntity: ErrorResultModel(
        message: e.message,
        statusCode: e.response?.statusCode ?? 900,
      ),
    );
  } else {
    return ApiResultModel<T>.failure(
      errorResultEntity: ErrorResultModel(
        message: e.toString(),
        statusCode: 900,
      ),
    );
  }
}