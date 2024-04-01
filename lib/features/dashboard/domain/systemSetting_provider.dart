import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/dashboard/data/ststemSettings_model.dart';
import 'package:beacon_flutter/features/dashboard/domain/systemSetting_repo.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/network_state.dart';

class SystemSettingProvider extends ChangeNotifier{
  final SystemSettingsRepo _settingsRepo = SystemSettingsRepo();
  SystemSettingsModel? systemSettingsModel;

  Future<BMSResponse<SystemSettingsModel>> getSystemSettings() async {
    await _settingsRepo.fetch(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            final Map<String,dynamic> _map = loadedState.response?.body;
            systemSettingsModel =
                systemSettingsFromJson(jsonEncode(_map['response']));
          },
          onErrorState: (errorState) {
            systemSettingsModel=null;

          },
          onLoadingState: (loadingState) {
          },
        );
      },
    );

    return BMSResponse(body: systemSettingsModel);
  }

}