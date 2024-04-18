import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pictures/app/base/app_widget.dart';

import 'app/base/app_module.dart';
import 'app/base/app_routes.dart';

void main() {
  Modular.setInitialRoute(AppRoutes.initialRoute);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
