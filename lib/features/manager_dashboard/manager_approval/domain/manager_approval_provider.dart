import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/data/accounts_houses_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/account_houses_repo.dart';
import 'package:flutter/foundation.dart';

class ManagerApprovalProvider extends ChangeNotifier {
  AccountHousesResponseModel? accountHousesResponseModel;
  bool isAccountHousesLoading = false;

  Future<BMSResponse<AccountHousesResponseModel>> getAccountHouses() async {
    final AccountHousesRepo accountHousesRepo = AccountHousesRepo();
    isAccountHousesLoading = true;
    notifyListeners();
    await accountHousesRepo.fetch(
      params: {},
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              accountHousesResponseModel = accountHousesResponseModelFromJson(
                  jsonEncode(map['response']));
            });
          },
          onErrorState: (errorState) {
            accountHousesResponseModel?.data = null;
            onFutureNotifyListeners(() {
              // loadedPostModel = errorState.response?.body;
            });
          },
          onLoadingState: (loadingState) {},
        );
      },
    );
    isAccountHousesLoading = false;
    notifyListeners();
    log("Account Response: ${accountHousesResponseModel?.data?.length}");
    return BMSResponse(body: accountHousesResponseModel);
  }
}
