import 'package:nasa_pictures/app/use_case/pictures_use_case.dart';

import '../../../base/base_view_model.dart';
import '../../../data/model/picture_response_model.dart';

class PicturesListViewModel extends BaseViewModel {
  PicturesListViewModel({required this.picturesUseCase});
  PicturesUseCase picturesUseCase;

  List<PictureResponseModel> get pictures => picturesUseCase.pictures;

  getPictures() async {
    setIsLoading(true);
    await picturesUseCase.getPictures();
    setIsLoading(false);
  }
}