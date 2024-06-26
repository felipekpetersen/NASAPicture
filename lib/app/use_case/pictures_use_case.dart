import '../data/model/picture_response_model.dart';
import '../data/repository/pictures/pictures_repository_imp.dart';

class PicturesUseCase {
  PicturesUseCase({required this.picturesRepository});

  PicturesRepositoryImp picturesRepository;
  List<PictureResponseModel> get pictures => picturesRepository.pictures;
  List<PictureResponseModel> get filteredPicture => picturesRepository.filteredPictures;
  PictureResponseModel? get selectedPicture => picturesRepository.selectedPicture;

  Future<void> getPictures() async {
    await picturesRepository.getPictures();
  }

  void selectPicture(PictureResponseModel selectPicture) {
    picturesRepository.selectPicture(selectPicture);
  }

  void searchPicture(String value) {
    picturesRepository.searchPicture(value);
  }
}