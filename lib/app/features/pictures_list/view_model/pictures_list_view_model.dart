import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/base/app_routes.dart';
import 'package:nasa_pictures/app/use_case/pictures_use_case.dart';

import '../../../base/base_view_model.dart';
import '../../../data/model/picture_response_model.dart';

class PicturesListViewModel extends BaseViewModel {
  PicturesListViewModel({required this.picturesUseCase});
  PicturesUseCase picturesUseCase;

  List<PictureResponseModel> get pictures => filteredPictures.isNotEmpty ? filteredPictures : picturesUseCase.pictures;
  List<PictureResponseModel> get filteredPictures => picturesUseCase.filteredPicture;

  TextEditingController searchController = TextEditingController();
  bool get noResultsSearch => searchController.text.isNotEmpty && filteredPictures.isEmpty;

  getPictures() async {
    setIsLoading(true);
    await picturesUseCase.getPictures();
    setIsLoading(false);
  }

  loadMorePictures() async {
    await picturesUseCase.getPictures();
    notifyListeners();
  }

  onSearch(String value) {
    picturesUseCase.searchPicture(value);
    notifyListeners();
  }

  onTapPicture(PictureResponseModel selectPicture) {
    picturesUseCase.selectPicture(selectPicture);
    Modular.to.pushNamed(AppRoutes.pictureDetailRoute);
  }
}