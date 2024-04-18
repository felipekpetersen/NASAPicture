
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/data/data_source/pictures/get_pictures_data_source_imp.dart';
import 'package:nasa_pictures/app/features/pictures_list/view/pictures_list_view.dart';
import 'package:nasa_pictures/app/features/pictures_list/view_model/pictures_list_view_model.dart';
import 'package:provider/provider.dart';

import '../data/repository/pictures/pictures_repository_imp.dart';
import 'app_routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    //DATASOURCE
    i.add<GetPicturesDataSourceImp>(GetPicturesDataSourceImp.new);

    //REPOSITORY
    i.add<PicturesRepositoryImp>(
            () => PicturesRepositoryImp(
            dataSource: Modular.get<GetPicturesDataSourceImp>()));

    //VIEWMODEL
    i.add<PicturesListViewModel>(
            () => PicturesListViewModel());

  }

  @override
  void routes(r) {
    r.child(AppRoutes.initialRoute,
        child: (context) => Consumer<PicturesListViewModel>(
            builder: (context, viewModel, child) =>
                PicturesListView(viewModel: viewModel)));
  }
}
