// import 'package:hive_flutter/adapters.dart';
// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

class BMSHiveModel {
  static const String localStorageKey = "bms_hive_kv";

  static const String ACCESS_TOKEN = "ACCESS-TOKEN";
  static const String USER_PROFILE = "USER_PROFILE";

  static late Box hive;

  //call only once in main()
  static Future<Box> init() async {
    final appDocumentDirectory =
        Directory.current.path; //await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory);
    Hive.initFlutter();
    hive = await Hive.openBox(localStorageKey);
    return hive;
  }
}
