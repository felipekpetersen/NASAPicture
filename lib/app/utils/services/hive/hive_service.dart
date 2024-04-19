import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nasa_pictures/app/data/model/picture_response_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  HiveService._();

  static init() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final appDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDirectory.path);
    }
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PictureResponseModelAdapter());
    }
  }

  static Future<bool> hasBox({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  static Future<void> addToBox<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
  }

  static Future<List<PictureResponseModel>> getFromBox(String boxName) async {
    List<PictureResponseModel> boxList = [];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }
}
