
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/data/data_source/pictures/get_pictures_data_source_imp.dart';
import 'package:nasa_pictures/app/features/picture_detail/view/picture_detail_view.dart';
import 'package:nasa_pictures/app/features/picture_detail/view_model/picture_detail_view_model.dart';
import 'package:nasa_pictures/app/features/pictures_list/view/pictures_list_view.dart';
import 'package:nasa_pictures/app/features/pictures_list/view_model/pictures_list_view_model.dart';
import 'package:nasa_pictures/app/use_case/pictures_use_case.dart';
import 'package:provider/provider.dart';

import '../data/repository/pictures/pictures_repository_imp.dart';
import 'app_routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    //DATASOURCE
    i.addSingleton<GetPicturesDataSourceImp>(GetPicturesDataSourceImp.new);

    //REPOSITORY
    i.addSingleton<PicturesRepositoryImp>(
            () => PicturesRepositoryImp(
            dataSource: Modular.get<GetPicturesDataSourceImp>()));

    //USECASE
    i.addSingleton<PicturesUseCase>(
            () => PicturesUseCase(
            picturesRepository: Modular.get<PicturesRepositoryImp>()));

    //VIEWMODEL
    i.addSingleton<PicturesListViewModel>(
            () => PicturesListViewModel(picturesUseCase: Modular.get<PicturesUseCase>()));
    i.addSingleton<PictureDetailViewModel>(
            () => PictureDetailViewModel(picturesUseCase: Modular.get<PicturesUseCase>()));

  }

  @override
  void routes(r) {
    r.child(AppRoutes.initialRoute,
        child: (context) => Consumer<PicturesListViewModel>(
            builder: (context, viewModel, child) =>
                PicturesListView(viewModel: viewModel)));
    r.child(AppRoutes.pictureDetailRoute,
        child: (context) => Consumer<PictureDetailViewModel>(
            builder: (context, viewModel, child) =>
                PictureDetailView(viewModel: viewModel)));
  }
}
