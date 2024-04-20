import 'package:nasa_pictures/app/data/data_source/local/pictures/local_get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/model/picture_response_model.dart';
import 'package:nasa_pictures/app/utils/constants/app_strings.dart';
import 'package:nasa_pictures/app/utils/services/hive/hive_service.dart';

class LocalGetPicturesDataSourceImp implements LocalGetPicturesDataSource {
  @override
  Future<List<PictureResponseModel>> getPictures(int page, int numberOfItemsPerPage) async {
    final data = await HiveService.getFromBox(AppStrings.picturesBox);
    final filteredData = data.getRange(page*numberOfItemsPerPage, page*numberOfItemsPerPage + numberOfItemsPerPage);
    return filteredData.toList();
  }

}