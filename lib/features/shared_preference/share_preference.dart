
import 'package:beacon_flutter/features/shared_preference/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp = locator<SharedPreferences>();
void storeString(String key, String value) {
  sp.setString(key, value);
}

void storeBool(String key, bool value) {
  sp.setBool(key, value);
}

void storeInt(String key, int value) {
  sp.setInt(key, value);
}

void storeDouble(String key, double value) {
  sp.setDouble(key, value);
}

void storeStringlist(String key, List<String> value) {
  sp.setStringList(key, value);
}

void removeFromStore(String key) {
  sp.remove(key);
}

String? getString(String key) {
  return sp.getString(key);
}

bool? getBool(String key) {
  return sp.getBool(key);
}

int? getInt(String key) {
  return sp.getInt(key);
}

double? getDouble(String key) {
  return sp.getDouble(key);
}

List? getStringList(String key) {
  return sp.getStringList(key);
}
