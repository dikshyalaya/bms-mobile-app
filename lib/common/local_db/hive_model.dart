// import 'package:hive_flutter/adapters.dart';
// ignore_for_file: constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class BMSHiveModel {
  static const String localStorageKey = "bms_hive_kv";

  static const String ACCESS_TOKEN = "ACCESS-TOKEN";
  static const String USER_PROFILE = "USER_PROFILE";

  static late Box hive;

  //call only once in main()
  static Future<Box> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.initFlutter();
    hive = await Hive.openBox(localStorageKey);
    return hive;
  }
}
