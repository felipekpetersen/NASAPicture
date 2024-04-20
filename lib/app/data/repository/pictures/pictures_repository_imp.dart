import 'package:hive/hive.dart';
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

  int page = 0;
  int get numberOfItemsPerPage => 10;
  String startingDate = DateService.getDaysAgo(DateService.today, 10);
  String endingDate = DateService.today;

  @override
  Future<void> getPictures() async {
    final cacheDuration =
        AppStringsController.getString(AppStrings.cacheDuration);
    final cachePage = AppStringsController.getInt(AppStrings.cachePage);

    if (cacheDuration != null && DateService.isLaterThanToday(cacheDuration)) {
      await HiveService.delete(AppStrings.picturesBox);
      await AppStringsController.delete(AppStrings.cacheDuration);
      await AppStringsController.delete(AppStrings.cachePage);
    }

    if (cacheDuration != null &&
        !DateService.isLaterThanToday(cacheDuration) &&
        cachePage != null &&
        cachePage >= page) {
      print('Getting local data...');
      await getPicturesFromLocal(startingDate, endingDate);
    } else {
      print('Getting remote data...');
      await getPicturesFromRemote(startingDate, endingDate);
    }

    endingDate = DateService.getDayBefore(startingDate);
    startingDate = DateService.getDaysAgo(endingDate, 10);
    startingDate = DateService.getDayAfter(startingDate);

  }

  getPicturesFromRemote(String firstDate, String endDate) async {
    final result = await dataSource.getPictures(
        startingDate: firstDate, endingDate: endDate);

    switch (result) {
      case Success(value: final success):
        try {
          var responsePictures = List<PictureResponseModel>.from(
              success.data.map((x) => PictureResponseModel.fromJson(x)));
          responsePictures = responsePictures.reversed.toList();
          pictures.addAll(responsePictures);
          saveToCache(responsePictures);
          page++;

        } catch (err) {
          await getPicturesFromLocal(firstDate, endDate);
        }
      case Failure(exception: final exception):
        await getPicturesFromLocal(firstDate, endDate);
    }
  }

  getPicturesFromLocal(String firstDate, String endDate) async {
    try {
      pictures
          .addAll(await localDataSource.getPictures(page, numberOfItemsPerPage));
      page++;
    } catch(e) {
      getPicturesFromRemote(firstDate, endDate);
    }
  }

  saveToCache(List<PictureResponseModel> responsePictures) async {
    print('Saving to Hive...');
    await AppStringsController.setInt(AppStrings.cachePage, page);
    await AppStringsController.setString(
        AppStrings.cacheDuration, DateService.today);
    HiveService.addToBox(responsePictures, AppStrings.picturesBox);
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
        } else if(picture.date != null &&
            picture.date!.toLowerCase().contains(value.toLowerCase())) {
          filteredPictures.add(picture);
        }
      }
    }
  }
}
