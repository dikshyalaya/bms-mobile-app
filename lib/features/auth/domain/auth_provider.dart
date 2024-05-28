// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_repo.dart';
import 'package:beacon_flutter/features/auth/widget/change_password_page.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  BmsUserModel? _bmsUserModel;

  BmsUserModel? get bmsUserModel => _bmsUserModel;
  String get userFullName =>
      "${_bmsUserModel?.empFirstName ?? ''} ${_bmsUserModel?.empLastName ?? ''}";

  set bmsUserModel(BmsUserModel? value) {
    _bmsUserModel = value;
  }

  final LoginRepo _loginRepo = LoginRepo();
  final ChangePasswordRepo _changePasswordRepo = ChangePasswordRepo();
  final SendOtpByEmailRepo _sendOtpByEmailRepo = SendOtpByEmailRepo();
  final ResetPasswordRepo _resetPasswordRepo = ResetPasswordRepo();

  Future<void> logIn(
    String name,
    String password,
    String fcm, {
    LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
    ErrorStateCallback<Map<String, dynamic>>? onErrorState,
    LoadedStateCallback<Map<String, dynamic>>? onLoadedState,
    ValueChanged<Map<String, dynamic>>? onAccessToken,
  }) async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

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
      onAccessToken: (val) {
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

  Future<void> login(
    BuildContext context,
    String name,
    String password,
    String fcm,
  ) async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final url = Uri.parse(
        "https://api-beacon.dikshyalaya.com/api/Authentication/login");
    var body = {
      "password": password,
      "loginName": name,
      "fcmToken": fcm,
      "location": {
        "latitude": position.latitude,
        "longitude": position.longitude
      }
    };
    var headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(
      url,
      body: json.encode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final accessToken = data["accessToken"];
        final email = data['data']['email'];
        final isActive = data['data']['isActive'];
        final userTypeId = data['data']['userTypeId'];
        final empId = data['data']['empId'];
        final empFirstName = data['data']['employee']['empFirstName'];
        final empLastName = data['data']['employee']['empLastName'];
        final isPasswordUpdateRequired =
            data['data']['isPasswordUpdateRequired'];
        savedLoginInfo(
          accessToken,
          BmsUserModel(
            email: email,
            isActive: isActive,
            userTypeId: userTypeId,
            empFirstName: empFirstName,
            empLastName: empLastName,
            empId: empId,
            isPasswordUpdateRequired: isPasswordUpdateRequired,
          ),
        );
        //Navigate to page
        if (userTypeId == 1) {
          if (isPasswordUpdateRequired == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswordPage(
                  userTypeId: userTypeId as int,
                ),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashBoardScreen()),
              (route) => false,
            );
          }
        } else if (userTypeId == 4) {
          if (isPasswordUpdateRequired == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswordPage(
                  userTypeId: userTypeId as int,
                ),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ManagerDashBoardScreen()),
              (route) => false,
            );
          }
        } else {}
      } else {
        shoErrorToast(data['message']);
      }
    } else {
      final data = json.decode(response.body);
      shoErrorToast(data['message']);
    }
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

  Future<void> sendOtpByEmail(String email,
      {LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
      ErrorStateCallback<Map<String, dynamic>>? onErrorState,
      LoadedStateCallback<Map<String, dynamic>>? onLoadedState}) async {
    _sendOtpByEmailRepo.post(
      body: {
        "email": email,
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

  Future<void> resetPassword(
      String otpVaue, String newPassword, String confirmPassword,
      {LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
      ErrorStateCallback<Map<String, dynamic>>? onErrorState,
      LoadedStateCallback<Map<String, dynamic>>? onLoadedState}) async {
    _resetPasswordRepo.post(
      body: {
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
        "otp": otpVaue
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

  void savedLoginInfo(String accessToken, BmsUserModel bmsUserModel) async {
    await BMSHiveModel.hive.put(BMSHiveModel.ACCESS_TOKEN, accessToken);
    await BMSHiveModel.hive
        .put(BMSHiveModel.USER_PROFILE, jsonEncode(bmsUserModel.toJson()));
    await getUserDetail();
  }

  Future<BmsUserModel> getUserDetail() async {
    await BMSHiveModel.init();
    final response = await BMSHiveModel.hive.get(BMSHiveModel.USER_PROFILE);
    if (response != null) {
      _bmsUserModel = BmsUserModel.fromJson(jsonDecode(response));
    }
    notifyListeners();

    return _bmsUserModel ??
        BmsUserModel(
            email: "",
            empLastName: "",
            empFirstName: "",
            empId: 0,
            userTypeId: 0,
            isActive: false,
            isPasswordUpdateRequired: false);
  }

  void logOut() async {
    await BMSHiveModel.hive.clear();
  }
}
