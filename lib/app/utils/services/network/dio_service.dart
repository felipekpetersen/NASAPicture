import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nasa_pictures/app/utils/constants/app_strings.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_interceptor.dart';


enum RequestError {
  unknown, timeout, wrongParameters, notAuth
}

enum RequestBaseURL {
  onboarding, balance, withdraw, tokenValidator
}

sealed class Result<S, E extends RequestError> {
  const Result();
}

final class Success<S, E extends RequestError> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends RequestError> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: AppStrings.baseURL,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
    dio.interceptors.add(DioInterceptor());
  }

  static Future<Result<Response, RequestError>> getData(
      {required String path, Map<String, dynamic>? query,}) async {
    try {
      query ??= {
      };
      final url = dio.options.baseUrl + path;
      final response = await dio.get(url, queryParameters: query);
      return _handleResponse(response, path);

    } on DioException catch(e) {
      print('ERROR: ${e.toString()}');
      return _handleError(e.response?.statusCode, path);
    }
  }

  static Future<Result<Response, RequestError>> postData({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.post(path, data: data, queryParameters: query);
      return _handleResponse(response, path);

    } on DioException catch(e) {
      e.response?.statusCode;
      return _handleError(e.response?.statusCode, path);
      // return Failure(RequestError.unknown);
    }
  }


  static Result<Response, RequestError> _handleResponse(Response<dynamic> response, String path) {
    RequestError failure = RequestError.unknown;

    switch (response.statusCode) {
      case 200:
      case 201:
        return Success(response);
      case 401:
      case 403:
      case 422:
        failure = RequestError.wrongParameters;
      case 404:
        failure = RequestError.timeout;
      default:
        failure = RequestError.unknown;
    }
    return Failure(failure);
  }

  static Result<Response, RequestError> _handleError(int? statusCode, String path) {
    RequestError failure = RequestError.unknown;

    switch (statusCode) {
      case 401:
      case 403:
      case 422:
        failure = RequestError.wrongParameters;
      case 404:
        failure = RequestError.timeout;
      default:
        failure = RequestError.unknown;
    }

    return Failure(failure);
  }
}