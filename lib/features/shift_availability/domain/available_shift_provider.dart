import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/my_schedule/data/available_shift_for_dc_model.dart';
import 'package:beacon_flutter/features/shift_availability/domain/available_shift_repo.dart';
import 'package:flutter/cupertino.dart';

class AvailableShiftProvider extends ChangeNotifier {
  final int dcId;

  AvailableShiftProvider(this.dcId);

  bool isDataFetching = false;
  bool isDataPosting = false;
  int selectedIndex = -1;
  List<int> shiftIds = [];

  void addRemoveShiftId(bool add, int id) {
    if (add) {
      if (shiftIds.contains(id) == false) {
        shiftIds.add(id);
      }
    } else {
      shiftIds.remove(id);
    }
    notifyListeners();
  }

  AvailableShiftsForDcModel? _availableShiftsForDcModel;

  AvailableShiftsForDcModel get availableShiftsForDcModel =>
      _availableShiftsForDcModel ?? AvailableShiftsForDcModel();

  set availableShiftsForDcModel(AvailableShiftsForDcModel value) {
    _availableShiftsForDcModel = value;
  }

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }

  void setDataPosting(bool val) {
    isDataPosting = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<AvailableShiftsForDcModel>>
      getAvailableShiftsForDcModel() async {
    final AvailableShiftRepo availableShiftRepo =
        AvailableShiftRepo(dcId.toString());
    setLoading(true);
    await availableShiftRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                availableShiftsForDcModel = availableShiftsForDcModelFromJson(
                    jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              availableShiftsForDcModel.data = null;
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {},
          );
        });
    setLoading(false);
    return BMSResponse(body: availableShiftsForDcModel);
  }

  Future<void> postShiftAvailability(
      List<int> availableShifts, VoidCallback onCompleteCallBack) async {
    // final PostShiftAvailabilityRepo postShiftAvailabilityRepo =
    //     PostShiftAvailabilityRepo();
    setDataPosting(true);
    for (int shiftId in shiftIds) {
      _availableShiftsForDcModel?.data
          ?.removeWhere((element) => element.id == shiftId);
    }
    shiftIds.clear();
    notifyListeners();
    // await postShiftAvailabilityRepo.post(
    //     apiCallback: (networkState) {
    //       onApiCallback<dynamic>(
    //         networkState: networkState,
    //         onLoadedState: (loadedState) {
    //           setDataPosting(false);
    //           onCompleteCallBack.call();
    //         },
    //         onErrorState: (errorState) {
    //           setDataPosting(false);
    //           shoErrorToast(errorState.message);
    //         },
    //         onLoadingState: (loadingState) {},
    //       );
    //     },
    //     body: availableShifts);
    setDataPosting(false);
  }
}
