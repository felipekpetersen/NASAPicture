import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/base/app_widget.dart';

import 'app/base/app_module.dart';
import 'app/base/app_routes.dart';
import 'app/utils/constants/app_strings.dart';
import 'app/utils/services/hive/hive_service.dart';
import 'app/utils/services/network/dio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStringsController.init();
  DioHelper.init();
  await HiveService.init();
  Modular.setInitialRoute(AppRoutes.initialRoute);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
