// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/constants/enums.dart';
import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/admin_dashboard/src/admin_dashboard_screen.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_repo.dart';
import 'package:beacon_flutter/features/auth/widget/change_password_page.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  BmsUserModel? _bmsUserModel;

  BmsUserModel? get bmsUserModel => _bmsUserModel;
  String get userFullName =>
      "${_bmsUserModel?.empFirstName ?? ''} ${_bmsUserModel?.empLastName ?? ''}";

  set bmsUserModel(BmsUserModel? value) {
    _bmsUserModel = value;
  }

  // final LoginRepo _loginRepo = LoginRepo();
  final ChangePasswordRepo _changePasswordRepo = ChangePasswordRepo();
  final SendOtpByEmailRepo _sendOtpByEmailRepo = SendOtpByEmailRepo();
  final ResetPasswordRepo _resetPasswordRepo = ResetPasswordRepo();
  final SignupRepo _signupRepo = SignupRepo();

  bool isAgreeTerms = false;

  void toggleAgreeTerms() {
    isAgreeTerms = !isAgreeTerms;
    notifyListeners();
  }

  // Future<void> logIn(
  //   String name,
  //   String password,
  //   String fcm, {
  //   LoadingStateCallback<Map<String, dynamic>>? onLoadingState,
  //   ErrorStateCallback<Map<String, dynamic>>? onErrorState,
  //   LoadedStateCallback<Map<String, dynamic>>? onLoadedState,
  //   ValueChanged<Map<String, dynamic>>? onAccessToken,
  // }) async {
  //   final hasPermission = await handleLocationPermission();
  //   if (!hasPermission) return;
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   _loginRepo.post(
  //     body: {
  //       "password": password,
  //       "loginName": name,
  //       "fcmToken": fcm,
  //       "location": {
  //         "latitude": position.latitude,
  //         "longitude": position.longitude
  //       }
  //     },
  //     onAccessToken: (val) {
  //       onAccessToken?.call(val);
  //     },
  //     apiCallback: (networkState) {
  //       onApiCallback(
  //           networkState: networkState,
  //           onLoadedState: onLoadedState,
  //           onErrorState: onErrorState,
  //           onLoadingState: onLoadingState);
  //     },
  //   );
  // }

  Future<void> login(
    BuildContext context,
    String name,
    String password,
    String fcm,
  ) async {
    // final hasPermission = await handleLocationPermission("You must enable location to login");
    // if (!hasPermission) {
    //   showLocationDeniedDialog(context,"Enable Location","You must enable location to login");
    //   return;}
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    final url = Uri.parse(
        "https://api-beacon.dikshyalaya.com/api/Authentication/Login");
    var body = {
      "password": password,
      "loginName": name,
      "fcmToken": fcm,
      // "location": {
      //   "latitude": position.latitude,
      //   "longitude": position.longitude
      // }
    };
    var headers = {
      "Content-Type": "application/json",
    };
    // DateTime startTime = DateTime.now();

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
          switch (userTypeId) {
            case 1:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => name.toLowerCase() == 'beacon'
                        ? const AdminDashboardScreen()
                        : const DashBoardScreen()),
                (route) => false,
              );
              break;
            case 4:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManagerDashBoardScreen()),
                (route) => false,
              );
              break;
            //  case 0:
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const AdminDashboardScreen()),
            //   (route) => false,
            // );
            // break;
            default:
              // Handle other user types if necessary
              break;
          }
        }
      } else {
        DialogueUtils.popUpMessageDialogue(
          context: context,
          message: data['message'],
          popUpType: PopUpType.error,
        );
      }
    } else {
      final data = json.decode(response.body);
      DialogueUtils.popUpMessageDialogue(
        context: context,
        message: data['message'],
        popUpType: PopUpType.error,
      );
    }
  }

  Future<void> signUp(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    Navigator.pop(context);
    DialogueUtils.popUpMessageDialogue(
      context: context,
      message:
          "Your request has been submitted successfully. An confirmation link has been sent to your email. Please check your mail.",
      popUpType: PopUpType.success,
    );
    // _signupRepo.post(
    //   body: {
    //     "firstName": firstName,
    //   },
    //   apiCallback: (networkState) {
    //     onApiCallback(
    //       networkState: networkState,
    //       onLoadedState: (loadedState) {
    //         final data = loadedState.response?.body;
    //         log("SignRedponse $data");
    //         log("Respoinse type ${data.runtimeType}");
    //       },
    //       onErrorState: (onErrorState) {},
    //       onLoadingState: (onLoadingState) {},
    //     );
    //   },
    // );
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

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
