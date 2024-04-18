import '../data/model/picture_response_model.dart';
import '../data/repository/pictures/pictures_repository_imp.dart';

class PicturesUseCase {
  PicturesUseCase({required this.picturesRepository});

  PicturesRepositoryImp picturesRepository;
  List<PictureResponseModel> get pictures => picturesRepository.pictures;

  Future<void> getPictures() async {
    await picturesRepository.getPictures('2024-04-01');
  }
}