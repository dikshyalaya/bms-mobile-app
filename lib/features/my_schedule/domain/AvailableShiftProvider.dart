import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/auth/widget/login_screen.dart';
import 'package:beacon_flutter/features/my_schedule/data/AvailableShiftsForDCModel.dart';
import 'package:beacon_flutter/features/my_schedule/domain/available_shift_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AvailableShiftProvider extends ChangeNotifier {
  final int dcId;

  AvailableShiftProvider(this.dcId);

  bool isDataFetching = false;
  bool isDataPosting = false;

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
              availableShiftsForDcModel?.data = null;
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

  void cancelShift(int shiftId) async{
    setDataPosting(true);

    final CancelShiftRepo cancelShiftRepo=
    CancelShiftRepo(shiftId);
    await cancelShiftRepo.fetch(

        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            onLoadedState: (loadedState) {
              Fluttertoast.showToast(msg: "Successfully cancelled the shift");
            },
            onErrorState: (errorState) {
              shoErrorToast(errorState.message);
            },
            onLoadingState: (loadingState) {},
          );
        });
    setDataPosting(false);
  }
}
