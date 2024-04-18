
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/features/pictures_list/view_model/pictures_list_view_model.dart';
import 'package:nasa_pictures/app/utils/services/network/dio_service.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DioHelper.init();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => Modular.get<PicturesListViewModel>()),
        ],
        child: MaterialApp.router(
            builder: (context, child) {
              return child!;
            },
            title: "Nasa Pictures",
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser));
  }
}
