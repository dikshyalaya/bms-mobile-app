import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/dashboard/data/system_settings_model.dart';
import 'package:beacon_flutter/features/dashboard/domain/system_setting_repo.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/network_state.dart';

class SystemSettingProvider extends ChangeNotifier {
  final SystemSettingsRepo _settingsRepo = SystemSettingsRepo();
  SystemSettingsModel? systemSettingsModel;
  bool isLoading = false;

  Future<BMSResponse<SystemSettingsModel>> getSystemSettings() async {
    isLoading = true;
    await _settingsRepo.fetch(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            final Map<String, dynamic> map = loadedState.response?.body;
            systemSettingsModel =
                systemSettingsFromJson(jsonEncode(map['response']));
          },
          onErrorState: (errorState) {
            systemSettingsModel = null;
          },
          onLoadingState: (loadingState) {},
        );
      },
    );
    isLoading = false;
    notifyListeners();

    return BMSResponse(body: systemSettingsModel);
  }
}
