import 'package:nasa_pictures/app/data/data_source/pictures/get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/model/picture_request_model.dart';
import 'package:nasa_pictures/app/data/repository/pictures/pictures_repository.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_service.dart';

class PicturesRepositoryImp implements PicturesRepository {
  PicturesRepositoryImp({required this.dataSource});
  final GetPicturesDataSource dataSource;

  List<PictureResponseModel> pictures = [];

  @override
  void getPictures(String? startingDate) async {
    final result = await dataSource.getPictures(startingDate);

    switch(result) {
      case Success(value: final success):
        try {
          pictures = List<PictureResponseModel>.from(success.data.map((x) => PictureResponseModel.fromJson(x)));
        } catch(err) {
          print(err);
        }
      case Failure(exception: final exception):

    }
  }

}