import 'package:dio/dio.dart';

import '../../../../utils/services/network/dio_service.dart';

abstract class GetPicturesDataSource {

  Future<Result<Response<dynamic>, RequestError>> getPictures(
      {String? startingDate, String? endingDate});

}