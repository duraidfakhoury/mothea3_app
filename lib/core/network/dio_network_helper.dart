import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mothea3_app/core/network/network_errors_handler.dart';

import 'network_helper.dart';

class DioNetworkHelper extends NetworkHelper {
  DioNetworkHelper._() : super.create();
  static DioNetworkHelper? _instance;
  factory DioNetworkHelper() => _instance ??= DioNetworkHelper._();

  final _dio = Dio();
  Logger logger = Logger();

  // on post request
  @override
  Future<NetworkResponse> post(
    String url, {
    Map<String, dynamic>? headers,
    Object? data,
    Future<NetworkResponse> Function(RequestFunction function)?
        exceptionThrower,
  }) async {
    logger.d(
        "============== POST METHOD ================= \n URL: ($url) \n ${data != null ? "Parameters: $data" : ''}");
    if (headers != null) logger.i(headers);


    final process = _dio.post(
      url,
      data: data,
      options: Options(headers: headers ?? this.headers.defaultHeaders),
    );

    return exceptionThrower?.call(() => process) ??
        handler?.defaultExceptionThrower(() => process) ??
        NetworkErrorsHandler().defaultExceptionThrower(() => process);
  }

  // on put request
  @override
  Future<NetworkResponse> put(
    String url, {
    Map<String, dynamic>? headers,
    Object? data,
    Future<NetworkResponse> Function(RequestFunction function)?
        exceptionThrower,
  }) async {
    logger.d(
        "============== PUt METHOD ================= \n URL: ($url) \n ${data != null ? "Parameters: $data" : ''}");
    if (headers != null) logger.i(headers);


    final process = _dio.put(
      url,
      data: data,
      options: Options(headers: headers ?? this.headers.defaultHeaders),
    );

    return exceptionThrower?.call(() => process) ??
        handler?.defaultExceptionThrower(() => process) ??
        NetworkErrorsHandler().defaultExceptionThrower(() => process);
  }

  // on delete request
  @override
  Future<NetworkResponse> delete(
    String url, {
    Map<String, dynamic>? headers,
    Object? data,
    Future<NetworkResponse> Function(RequestFunction function)?
        exceptionThrower,
  }) async {
    logger.d(
        "============== DELETE METHOD ================= \n URL: ($url) \n ${data != null ? "Parameters: $data" : ''}");
    if (headers != null) logger.i(headers);


    final process = _dio.delete(
      url,
      data: data,
      options: Options(headers: headers ?? this.headers.defaultHeaders),
    );

    return exceptionThrower?.call(() => process) ??
        handler?.defaultExceptionThrower(() => process) ??
        NetworkErrorsHandler().defaultExceptionThrower(() => process);
  }

  // on get request
  @override
  Future<NetworkResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    Object? data,
    Future<NetworkResponse> Function(RequestFunction function)?
        exceptionThrower,
  }) async {
    logger.d(
        "============== GET METHOD ================= \n URL: ($url) \n ${data != null ? "Parameters: $data" : ''}");
    if (headers != null) logger.i(headers);

    final process = _dio.get(
      url,
      data: data,
      options: Options(headers: headers ?? this.headers.defaultHeaders),
    );

    return exceptionThrower?.call(() => process) ??
        handler?.defaultExceptionThrower(() => process) ??
        NetworkErrorsHandler().defaultExceptionThrower(() => process);
  }
}
