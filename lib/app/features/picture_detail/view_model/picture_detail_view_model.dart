import 'package:nasa_pictures/app/base/base_view_model.dart';
import 'package:nasa_pictures/app/data/model/picture_response_model.dart';
import 'package:nasa_pictures/app/use_case/pictures_use_case.dart';

class PictureDetailViewModel extends BaseViewModel {
  PictureDetailViewModel({required this.picturesUseCase});

  final PicturesUseCase picturesUseCase;
  PictureResponseModel? get selectedPicture => picturesUseCase.selectedPicture;
}