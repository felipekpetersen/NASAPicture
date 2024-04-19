import 'package:dio/dio.dart';
import 'package:nasa_pictures/app/data/data_source/remote/pictures/get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/model/picture_request_model.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_service.dart';

class GetPicturesDataSourceImp implements GetPicturesDataSource {
  @override
  Future<Result<Response, RequestError>> getPictures(String? startingDate) {
    final pictureRequestModel = PictureRequestModel(startDate: startingDate);
    return DioHelper.getData(path: 'planetary/apod', query: pictureRequestModel.toJson());
  }
}