import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/data/accounts_houses_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/data/shift_for_approval_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/account_houses_repo.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/shift_for_approval_repo.dart';
import 'package:flutter/foundation.dart';

class ManagerApprovalProvider extends ChangeNotifier {
  AccountHousesResponseModel? accountHousesResponseModel;
  ShiftForApprovalResponseModel? shiftForApprovalResponseModel;

  List<int> selectedShifts = [];

  bool isAccountHousesLoading = false;
  bool isShiftForApprovalLoading = false;
  bool isShiftApprovalPosting = false;

  //Fetch Accounts and Houses
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
              log("Account Response: ${accountHousesResponseModel?.data?.first.accountNumber}");
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
    notifyListeners();
    log("Account Response: ${accountHousesResponseModel?.data?.length}");
    isAccountHousesLoading = false;
    return BMSResponse(body: accountHousesResponseModel);
  }

  //Fetch all list of shifts approval related to houses
  Future<BMSResponse<AccountHousesResponseModel>> getListShiftForApproval(
      {required String houseId}) async {
    final ShiftForApprovalRepo shiftForApprovalRepo = ShiftForApprovalRepo();
    isShiftForApprovalLoading = true;
    notifyListeners();
    await shiftForApprovalRepo.fetch(
      params: {'houseId': houseId},
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              shiftForApprovalResponseModel =
                  shiftForApprovalResponseModelFromJson(
                      jsonEncode(map['response']));
              log("Account List For Approval: ${shiftForApprovalResponseModel?.data?.first.id}");
              log("Account List Length: ${shiftForApprovalResponseModel?.data?.length}");
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
    notifyListeners();
    log("Account Response: ${accountHousesResponseModel?.data?.length}");
    isShiftForApprovalLoading = false;
    return BMSResponse(body: accountHousesResponseModel);
  }

  //Add or remove selected shift
  void addOrRemoveSelectedShift(int shiftId, bool val) {
    if (val) {
      selectedShifts.add(shiftId);
    } else {
      selectedShifts.remove(shiftId);
    }
    log("Selected Shifts: $selectedShifts");
    notifyListeners();
  }

  // Post Approval Shift Data
  Future<BMSResponse<AccountHousesResponseModel>>
      postListShiftForApproval() async {
    final ShiftForApprovalRepo shiftForApprovalRepo = ShiftForApprovalRepo();
    isShiftApprovalPosting = true;
    notifyListeners();
    await shiftForApprovalRepo.post(
      params: {},
      body: {"shfitsToApprove": selectedShifts},
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              shiftForApprovalResponseModel =
                  shiftForApprovalResponseModelFromJson(
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
    notifyListeners();
    log("Account Response: ${accountHousesResponseModel?.data?.length}");
    isShiftApprovalPosting = false;
    return BMSResponse(body: accountHousesResponseModel);
  }
}
