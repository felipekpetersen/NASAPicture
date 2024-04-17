import 'package:dio/dio.dart';
import 'package:nasa_pictures/app/utils/constants/app_strings.dart';

class DioInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      'api_key': AppStrings.apiKey
    });

    super.onRequest(options, handler);
  }

}