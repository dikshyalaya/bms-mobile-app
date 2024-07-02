import 'dart:developer';

import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/common/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserProfileProvider extends ChangeNotifier {
  // final UserProfilePicRepo _userProfilePicRepo = UserProfilePicRepo();

  Future<bool> updateProfilePic(String imagePath) async {
    bool isSuccess = false;
    final url = Uri.parse("$baseUrl$userProfilePic/");
    final accessToken = await BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
    try {
      final request = http.MultipartRequest(
        'POST',
        url,
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'File',
          imagePath,
        ),
      );
      request.headers.addAll({'Authorization': "Bearer $accessToken"});
      request.send().then((response) {
        log("Response: ${response.statusCode}");
        if (response.statusCode == 200) {
          isSuccess = true;
        }
      });
    } catch (e) {
      log("Something went wrong while updating profile pic: $e");
      isSuccess = false;
    }

    return isSuccess;
  }

  // Future<BMSResponse<SystemSettingsModel>> getSystemSettings() async {
  //   await _settingsRepo.fetch(
  //     apiCallback: (networkState) {
  //       onApiCallback<dynamic>(
  //         networkState: networkState,
  //         onLoadedState: (loadedState) {
  //           final Map<String, dynamic> map = loadedState.response?.body;
  //           systemSettingsModel =
  //               systemSettingsFromJson(jsonEncode(map['response']));
  //         },
  //         onErrorState: (errorState) {
  //           systemSettingsModel = null;
  //         },
  //         onLoadingState: (loadingState) {},
  //       );
  //     },
  //   );

  //   return BMSResponse(body: systemSettingsModel);
  // }
}
