import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/data/look_for_shift_response_model.dart';
import 'package:beacon_flutter/features/looking_for_shift/data/schedule_period_response_model.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_repo.dart';
import 'package:flutter/cupertino.dart';

class LookingForShiftProvider extends ChangeNotifier {
  final int dcId;

  LookingForShiftProvider(this.dcId);

  bool isDataFetching = false;
  bool isDataPosting = false;
  List<int> lookForShiftIds = [];
  void addRemoveShiftIds(bool add, int id) {
    if (add) {
      lookForShiftIds.add(id);
    } else {
      lookForShiftIds.remove(id);
    }
    notifyListeners();
  }

  SchedulePeriodResponseModel? _schedulePeriodResponseModel;
  LookForShiftResponseModel? _lookForShiftResponseModel;

  final SchedulePeriodRepo _schedulePeriodRepo = SchedulePeriodRepo();
  final LookingForShiftRepo _lookingForShiftRepo = LookingForShiftRepo();
  final PostAvailableForShiftReo _postAvailableForShiftReo =
      PostAvailableForShiftReo();

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }

  void setDataPosting(bool val) {
    isDataPosting = val;
    futureNotifyListeners();
  }

  LookForShiftResponseModel? get lookForShiftResponseModel =>
      _lookForShiftResponseModel;

  set lookForShiftResponseModel(LookForShiftResponseModel? value) {
    _lookForShiftResponseModel = value;
  }

  SchedulePeriodResponseModel? get schedulePeriodResponseModel =>
      _schedulePeriodResponseModel;

  set schedulePeriodResponseModel(SchedulePeriodResponseModel? value) {
    _schedulePeriodResponseModel = value;
  }

  Future<BMSResponse<SchedulePeriodResponseModel>>
      getAllSchedulePeriods() async {
    await _schedulePeriodRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                _schedulePeriodResponseModel =
                    schedulePeriodResponseModelFromJson(
                        jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              _schedulePeriodResponseModel?.data = null;
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {},
          );
        });
    return BMSResponse(body: _schedulePeriodResponseModel);
  }

  Future<BMSResponse<SchedulePeriodResponseModel>> getAllLookingForShift(
      String schedPeriod) async {
    setLoading(true);
    await _lookingForShiftRepo.post(
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              setLoading(false);
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                log("Looking for shift Response: ${jsonEncode(map['response'])}");
                _lookForShiftResponseModel = lookForShiftResponseModelFromJson(
                    jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              _lookForShiftResponseModel?.data = null;
              onFutureNotifyListeners(() {
                setLoading(false);
              });
            },
            onLoadingState: (loadingState) {},
          );
        },
        body: {"dcId": dcId.toString(), "schedulePeriod": schedPeriod});
    return BMSResponse(body: _schedulePeriodResponseModel);
  }

  void postAvailableForShift(
      List<int> availableShifts, VoidCallback onCompleteCallBack) async {
    setDataPosting(true);
    await _postAvailableForShiftReo.post(
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            onLoadedState: (loadedState) {
              setDataPosting(false);
              onCompleteCallBack.call();
            },
            onErrorState: (errorState) {
              setDataPosting(false);
              shoErrorToast(errorState.message);
            },
            onLoadingState: (loadingState) {},
          );
        },
        body: availableShifts);
    setDataPosting(false);
  }
}
