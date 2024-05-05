import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  locator
    .registerSingleton<SharedPreferences>(sharedPrefs);
  
}