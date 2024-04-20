import 'package:nasa_pictures/app/data/model/picture_response_model.dart';

abstract class LocalGetPicturesDataSource {
  Future<List<PictureResponseModel>> getPictures(int page, int numberOfItemsPerPage);
}