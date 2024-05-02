import 'dart:convert';

import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_repo.dart';
import 'package:beacon_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class AuthProvider extends ChangeNotifier{

  BmsUserModel? _bmsUserModel;

  BmsUserModel? get bmsUserModel => _bmsUserModel;
  String get userFullName =>"${_bmsUserModel?.empFirstName??''} ${_bmsUserModel?.empLastName??''}";

  set bmsUserModel(BmsUserModel? value) {
    _bmsUserModel = value;
  }

  final LoginRepo _loginRepo =LoginRepo();
  final ChangePasswordRepo _changePasswordRepo =ChangePasswordRepo();
  Future<void> logIn(String name, String password,String fcm,
      {LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
        ErrorStateCallback<Map<String, dynamic>>? onErrorState,
        LoadedStateCallback<Map<String, dynamic>>? onLoadedState,ValueChanged<Map<String, dynamic>>? onAccessToken,}) async {

    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _loginRepo.post(
      body: {
        "password": password,
        "loginName": name,
        "fcmToken": fcm,
        "location": {
          "latitude": position.latitude,
          "longitude": position.longitude
        }

      },
      onAccessToken: (val){
        onAccessToken?.call(val);
      },
      apiCallback: (networkState) {
        onApiCallback(
            networkState: networkState,
            onLoadedState: onLoadedState,
            onErrorState: onErrorState,
            onLoadingState: onLoadingState);
      },
    );
  }

  Future<void> changePassword(String newPassword,
      {LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
        ErrorStateCallback<Map<String, dynamic>>? onErrorState,
        LoadedStateCallback<Map<String, dynamic>>? onLoadedState}) async {
    _changePasswordRepo.post(
      body: {
        "newPassword": newPassword,
      },
      apiCallback: (networkState) {
        onApiCallback(
            networkState: networkState,
            onLoadedState: onLoadedState,
            onErrorState: onErrorState,
            onLoadingState: onLoadingState);
      },
    );
  }

void savedLoginInfo(String accessToken,BmsUserModel bmsUserModel)async{
await  BMSHiveModel.hive.put(BMSHiveModel.ACCESS_TOKEN, accessToken);
 await BMSHiveModel.hive.put(BMSHiveModel.USER_PROFILE, jsonEncode(bmsUserModel.toJson()));
 await getUserDetail();
  }

  Future<BmsUserModel>getUserDetail()async{
    await BMSHiveModel.init();
    final response =  await BMSHiveModel.hive.get(BMSHiveModel.USER_PROFILE);
    if(response!=null){
      _bmsUserModel =  BmsUserModel.fromJson(jsonDecode(response));

    }
  notifyListeners();

  return _bmsUserModel??BmsUserModel(email: "", empLastName: "", empFirstName: "", empId: 0, userTypeId: 0, isActive: false);
  }

  void logOut()async{
   await BMSHiveModel.hive.clear();
  }

}