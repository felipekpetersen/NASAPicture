import 'package:nasa_pictures/app/data/data_source/pictures/get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/repository/pictures/pictures_repository.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_service.dart';

import '../../model/picture_response_model.dart';

class PicturesRepositoryImp implements PicturesRepository {
  PicturesRepositoryImp({required this.dataSource});
  final GetPicturesDataSource dataSource;

  List<PictureResponseModel> pictures = [];
  PictureResponseModel? _selectedPicture;
  PictureResponseModel? get selectedPicture => _selectedPicture;

  @override
  Future<void> getPictures(String? startingDate) async {
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

  selectPicture(PictureResponseModel selectPicture) {
    _selectedPicture = selectPicture;
  }

}