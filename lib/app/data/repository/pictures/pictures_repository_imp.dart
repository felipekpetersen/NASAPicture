import 'package:nasa_pictures/app/data/data_source/local/pictures/local_get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/data_source/remote/pictures/get_pictures_data_source.dart';
import 'package:nasa_pictures/app/data/repository/pictures/pictures_repository.dart';
import 'package:nasa_pictures/app/utils/constants/app_strings.dart';
import 'package:nasa_pictures/app/utils/services/date_service.dart';
import 'package:nasa_pictures/app/utils/services/hive/hive_service.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_service.dart';

import '../../model/picture_response_model.dart';

class PicturesRepositoryImp implements PicturesRepository {
  PicturesRepositoryImp(
      {required this.dataSource, required this.localDataSource});
  final GetPicturesDataSource dataSource;
  final LocalGetPicturesDataSource localDataSource;

  List<PictureResponseModel> pictures = [];
  List<PictureResponseModel> filteredPictures = [];
  PictureResponseModel? _selectedPicture;
  PictureResponseModel? get selectedPicture => _selectedPicture;
  String startingDate = DateService.today;

  @override
  Future<void> getPictures() async {
    final cacheDuration =
        AppStringsController.getString(AppStrings.cacheDuration);

    if (cacheDuration != null && !DateService.isLaterThanToday(cacheDuration)) {
      await getPicturesFromLocal();
    } else {
      await getPicturesFromRemote();
    }
  }

  getPicturesFromRemote() async {
    final date = DateService.tenDaysAgo(startingDate);
    final result = await dataSource.getPictures(date);

    switch (result) {
      case Success(value: final success):
        try {
          final responsePictures = List<PictureResponseModel>.from(
              success.data.map((x) => PictureResponseModel.fromJson(x)))
            ..reversed.toList();
          pictures.addAll(responsePictures);
          startingDate = date;
          await AppStringsController.setString(
              AppStrings.cacheDuration, DateService.today);
          HiveService.addToBox(pictures, AppStrings.picturesBox);
        } catch (err) {
          await getPicturesFromLocal();
        }
      case Failure(exception: final exception):
        await getPicturesFromLocal();
    }
  }

  getPicturesFromLocal() async {
    pictures = await localDataSource.getPictures();
  }

  selectPicture(PictureResponseModel selectPicture) {
    _selectedPicture = selectPicture;
  }

  searchPicture(String value) {
    filteredPictures.clear();
    if (value != '') {
      for (PictureResponseModel picture in pictures) {
        if (picture.title != null &&
            picture.title!.toLowerCase().contains(value.toLowerCase())) {
          filteredPictures.add(picture);
        }
      }
    }
  }
}
