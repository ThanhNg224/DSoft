import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:spa_project/base_project/api/dev_logger.dart';
import 'package:spa_project/base_project/package.dart';

class ServiceNetwork {
  final Dio _dio;
  final String baseUrl;
  ServiceNetwork({required this.baseUrl}) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(DevLogger());
  }

  final Duration _duration = const Duration(seconds: 11);

  Future<Result<T>> _request<T>({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: query,
        options: Options(method: method),
      ).timeout(_duration);
      return _handleResponse<T>(response, fromJson);
    } on TimeoutException {
      return Failure<T>(Result.isTimeOut);
    } on DioException catch (dioException) {
      if(dioException.type == DioExceptionType.connectionError) {
        return Failure<T>(Result.isNotConnect);
      } else {
        return Failure<T>(Result.isDueServer);
      }
    } catch (e) {
      dev.log(e.toString(), name: "isError");
      return Failure<T>(Result.isError);
    }
  }

  Future<Result<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    required T Function(dynamic) fromJson,
  }) {
    return _request<T>(
      endpoint: endpoint,
      method: 'GET',
      query: query,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    required T Function(dynamic) fromJson,
    bool withToken = false
  }) {
    return _request<T>(
      endpoint: endpoint,
      method: 'POST',
      data: _insertToken(withToken, data),
      fromJson: fromJson,
    );
  }

  Future<Result<T>> put<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    required T Function(dynamic) fromJson,
    bool withToken = false
  }) {
    return _request<T>(
      endpoint: endpoint,
      method: 'PUT',
      data: _insertToken(withToken, data),
      fromJson: fromJson,
    );
  }

  Future<Result<T>> delete<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required T Function(dynamic) fromJson,
    bool withToken = false
  }) {
    return _request<T>(
      endpoint: endpoint,
      method: 'DELETE',
      query: query,
      data: _insertToken(withToken, data),
      fromJson: fromJson,
    );
  }

  Result<T> _handleResponse<T>(Response response, T Function(dynamic)? fromJson) {
    if (response.statusCode == 200) {
      if (fromJson == null) return Success<T>(null as T);
      final data = response.data;
      return Success(fromJson(data));
    } else {
      return Failure<T>(Result.isHttp);
    }
  }

  Map<String, dynamic>? _insertToken(bool withToken, Map<String, dynamic>? data) {
    final token = Global.getString(MyConfig.TOKEN_STRING_KEY);
    // if (withToken) {
    //   data = {...?data, MyConfig.TOKEN_STRING_KEY: token};
    //   dev.log("USE TOKEN: $token", name: MyConfig.APP_NAME);
    // }
    data = {...?data, 'id_spa': Utilities.getIdSpaDefault};
    if (withToken) {
      data[MyConfig.TOKEN_STRING_KEY] = token;
      dev.log("USE TOKEN: $token", name: MyConfig.APP_NAME);
    }
    return data;
  }

  Future<Result<T>> postFormData<T>({
    required String endpoint,
    required FormData data,
    required T Function(dynamic) fromJson,
    bool withToken = false,
  }) async {
    try {
      if (withToken) {
        final token = Global.getString(MyConfig.TOKEN_STRING_KEY);
        data.fields.add(MapEntry(MyConfig.TOKEN_STRING_KEY, token));
        data.fields.add(MapEntry('id_spa', Utilities.getIdSpaDefault.toString()));
        dev.log("USE TOKEN: $token", name: MyConfig.APP_NAME);
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      ).timeout(_duration);

      return _handleResponse<T>(response, fromJson);
    } on TimeoutException {
      return Failure<T>(Result.isTimeOut);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionError) {
        return Failure<T>(Result.isNotConnect);
      } else {
        return Failure<T>(Result.isDueServer);
      }
    } catch (e) {
      dev.log(e.toString(), name: "isError");
      return Failure<T>(Result.isError);
    }
  }
}